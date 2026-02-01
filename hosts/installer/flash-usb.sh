# ./flash-usb.sh <device> <image-file>
# sudo hosts/installer/flash-usb.sh /dev/sda result/iso/nixos-minimal-26.05.20260125.48698d1-x86_64-linux.iso

wipefs -a $1
dd if=$2 of=$1 bs=4M status=progress conv=fsync
