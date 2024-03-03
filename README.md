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
├── renovate.json
├── .github
│   └── workflows
│       ├── check-flake.yaml
│       └── update-readme.yaml
├── hosts
│   ├── desktop.nix
│   └── laptop.nix
├── modules
│   ├── base
│   │   └── home-manager.nix
│   ├── hyprland
│   │   ├── home-manager.nix
│   │   ├── hyprland.conf
│   │   ├── wofi.css
│   │   └── waybar
│   │       ├── desktop.css
│   │       ├── desktop.json
│   │       ├── laptop.css
│   │       └── laptop.json
│   ├── terminal
│   │   ├── home-manager.nix
│   │   ├── init.lua
│   │   ├── tmux.conf
│   │   ├── vimrc
│   │   └── zshrc
│   └── virtualization
├── nixos
│   └── modules
│       ├── amd-cpu
│       ├── amd-gpu
│       ├── bluetooth
│       ├── boot
│       ├── luks
│       ├── lutris
│       ├── lvm
│       ├── nvidia
│       ├── obs
│       └── steam
├── scripts
│   └── install.sh
└── wallpapers
    ├── wallhaven-3lyrvy_3840x1600.png
    ├── wallhaven-7pm8yo.jpg
    ├── wallhaven-d62r9g_3840x1600.png
    ├── wallhaven-gpvr6q_3840x1600.png
    ├── wallhaven-gpvrwe_3840x1600.png
    └── wallhaven-jxr2pw_3840x1600.png
```
<!--END_SECTION:tree-->

# Flake

<!--START_SECTION:flake-->
```bash
└───nixosConfigurations
    ├───desktop: NixOS configuration
    └───laptop: NixOS configuration
```
<!--END_SECTION:flake-->

