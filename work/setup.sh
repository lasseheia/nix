# Remote installation
## Set up wifi connection
sudo systemctl start wpa_supplicant
wpa_cli add_network
wpa_cli set_network 0 ssid ""
wpa_cli set_network 0 psk ""
wpa_cli set_network 0 key_mgmt WPA-PSK
wpa_cli enable_network 0

## Set user password
passwd

# Partitioning
## Wipe the current disk
sudo blkdiscard /dev/nvme0n1

## Partition the disk
sudo parted /dev/nvme0n1 --script -- \
  mklabel gpt \
  mkpart ESP fat32 1MiB 1GiB \
  set 1 esp on \
  mkpart primary 1GiB 100%

# Format and encrypt the partitions
## Format the EFI partition and label it
sudo mkfs.fat -F 32 /dev/nvme0n1p1

## Set up LUKS2 encryption for the root partition
sudo cryptsetup luksFormat --type luks2 /dev/nvme0n1p2
sudo cryptsetup open /dev/nvme0n1p2 nixos-enc

# Set up LVM
## Create a physical volume on top of the opened LUKS container
sudo pvcreate /dev/mapper/nixos-enc

## Create a volume group
sudo vgcreate vg /dev/mapper/nixos-enc

## Create logical volumes
sudo lvcreate -L 50G vg -n root
sudo lvcreate -l +100%FREE vg -n home

## Format logical volumes
sudo mkfs.ext4 /dev/vg/root
sudo mkfs.ext4 /dev/vg/home

## Mount the logical volumes
sudo mount /dev/vg/root /mnt
sudo mkdir /mnt/home
sudo mount /dev/vg/home /mnt/home
sudo mkdir /mnt/boot
sudo mount /dev/nvme0n1p1 /mnt/boot

# Configure NixOS
## Clone GitHub repository
nix-env -iA nixos.git nixos.gh
gh auth login
gh repo clone lasseheia/nix

## Install nixos using flake
sudo nixos-install --flake .#nixos-orange --impure
