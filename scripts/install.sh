#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Inputs
hard_drive="/dev/$1"
hostname="$2"

# Validate inputs
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <hard drive> <hostname>"
    exit 1
fi

# Determine partition naming scheme based on the disk type
if [[ $hard_drive == *"nvme"* ]]; then
    partition_suffix="p"
else
    partition_suffix=""
fi

# Confirmation before proceeding
read -p "This will wipe the entire disk $hard_drive. Are you sure? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Start executing commands with error handling
set -e

# Partitioning
blkdiscard $hard_drive

# Create partitions
parted $hard_drive --script -- \
  mklabel gpt \
  mkpart ESP fat32 1MiB 512MiB \
  set 1 esp on \
  mkpart primary 512MiB 100%

# Assign partition names
boot_partition="${hard_drive}${partition_suffix}1"
root_partition="${hard_drive}${partition_suffix}2"

# Format and encrypt the partitions
mkfs.fat -F 32 $boot_partition
cryptsetup luksFormat --type luks2 $root_partition
cryptsetup open $root_partition nixos-enc

# LVM setup
pvcreate /dev/mapper/nixos-enc
vgcreate vg /dev/mapper/nixos-enc
lvcreate -L 50G vg -n root
lvcreate -l +100%FREE vg -n home

# Format and mount partitions
mkfs.ext4 /dev/vg/root
mkfs.ext4 /dev/vg/home
mount /dev/vg/root /mnt
mkdir -p /mnt/home
mount /dev/vg/home /mnt/home
mkdir -p /mnt/boot
mount $boot_partition /mnt/boot

# NixOS installation
nixos-install --flake "github:lasseheia/nix#$hostname"

# Clean up: Unmount partitions
umount /mnt/boot /mnt/home /mnt

# Close encrypted partition
cryptsetup close nixos-enc

# End of script
echo "Installation complete."

