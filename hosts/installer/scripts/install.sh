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
blkdiscard $hard_drive -f

# Create partitions with a larger boot partition
parted $hard_drive --script -- \
  mklabel gpt \
  mkpart ESP fat32 1MiB 2GiB \
  set 1 esp on \
  mkpart primary 2GiB 100%

# Assign partition names
boot_partition="${hard_drive}${partition_suffix}1"
root_partition="${hard_drive}${partition_suffix}2"

# Format boot partition
mkfs.fat -F 32 $boot_partition

# Encrypt root partition
cryptsetup luksFormat --type luks2 $root_partition
cryptsetup open $root_partition cryptroot

# Create ZFS pool on encrypted device with TRIM support
zpool create -f \
  -o ashift=12 \
  -O compression=lz4 \
  -O atime=off \
  -O xattr=sa \
  -O acltype=posixacl \
  -m none \
  -R /mnt \
  rpool /dev/mapper/cryptroot

#  -O autotrim=on \

# Create ZFS datasets with mountpoint=legacy
zfs create -o mountpoint=legacy rpool/root
zfs create -o mountpoint=legacy rpool/root/nixos
zfs create -o mountpoint=legacy rpool/root/home
zfs create -o mountpoint=legacy rpool/root/var
zfs create -o mountpoint=legacy -o atime=off rpool/root/nix

# Set correct mountpoints
mount -t zfs rpool/root/nixos /mnt
mkdir -p /mnt/{boot,home,var,nix}
mount -t zfs rpool/root/home /mnt/home
mount -t zfs rpool/root/var /mnt/var
mount -t zfs rpool/root/nix /mnt/nix
mount $boot_partition /mnt/boot

# Create a swap volume inside ZFS
zfs create -V 8G -b 4K -o compression=off -o sync=always -o primarycache=metadata rpool/swap
mkswap -f /dev/zvol/rpool/swap
swapon /dev/zvol/rpool/swap

# NixOS installation
nixos-install --flake "github:lasseheia/nix#$hostname"

# Clean up: Unmount partitions
umount -R /mnt
zpool export rpool
cryptsetup close cryptroot

# End of script
echo "Installation complete."
