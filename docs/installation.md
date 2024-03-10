## Installation

### 1. Connect to Wi-Fi

Follow the instructions in the NixOS manual to set up Wi-Fi:
https://nixos.org/manual/nixos/stable/#sec-installation-manual-networking

### 2. Download and Run the Installation Script

```bash
curl https://raw.githubusercontent.com/lasseheia/nix/main/scripts/install.sh | sudo bash [hard_drive_name] [hostname]
```

### What the Script Does

The script performs the following actions:

1. Wipes the specified disk
2. Creates new partitions
3. Encrypts the root partition
4. Sets up LVM on the root partition
5. Mounts all partitions
6. Downloads this repository
7. Installs NixOS
