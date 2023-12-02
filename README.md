# Nix configuration

## Installation

### Connect to Wi-FI

- https://nixos.org/manual/nixos/stable/#sec-installation-manual-networking

### Run the installation script

```bash
curl https://raw.githubusercontent.com/lasseheia/nix/main/scripts/install.sh | bash
```

This script will do the following:

1. Wipe the current disk
2. Create new partitions
3. Encrypt the root partition
4. Set up LVM on the root partition
5. Mount all partitions
6. Download this repository
7. Install NixOS

