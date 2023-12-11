# Nix Configurations

[![CI Checks](https://github.com/lasseheia/nix/actions/workflows/check-flake.yaml/badge.svg?branch=main&event=push)](https://github.com/lasseheia/nix/actions/workflows/check-flake.yaml)

This repository contains scripts and configurations for installing NixOS with an encrypted root partition and LVM setup.

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

# Manual fixes

## Mouse problems when playing World of Warcraft in Wayland
- https://github.com/doitsujin/dxvk/issues/966#issuecomment-555699559
- Add `SET rawMouseEnable "1"` to `/home/$USER/Games/battlenet/drive_c/Program Files (x86)/World of Warcraft/_classic_era_/WTF/Config.wtf`

# Repository file structure

<!--START_SECTION:tree-->
```bash
.
├── flake.lock
├── flake.nix
├── .github
│   ├── dependabot.yaml
│   └── workflows
│       ├── check-flake.yaml
│       ├── update-flake-lock.yaml
│       └── update-readme.yaml
├── home-manager
│   ├── base
│   └── modules
│       ├── browser
│       ├── hyprland
│       ├── terminal
│       └── waybar
├── nixos
│   ├── base
│   └── modules
│       ├── amd-cpu
│       ├── amd-gpu
│       ├── boot
│       ├── hyprland
│       ├── luks
│       ├── lutris
│       ├── lvm
│       ├── nvidia
│       ├── obs
│       ├── steam
│       └── virtualization
└── scripts
    └── install.sh
```
<!--END_SECTION:tree-->

# Flake

<!--START_SECTION:flake-->
```bash
```
<!--END_SECTION:flake-->

