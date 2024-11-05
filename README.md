# Nix Configurations

[![CI Checks](https://github.com/lasseheia/nix/actions/workflows/checks.yaml/badge.svg?branch=main&event=push)](https://github.com/lasseheia/nix/actions/workflows/checks.yaml)

This repository contains scripts and configurations for installing NixOS with an encrypted root partition and LVM setup.

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
├── docs
│   ├── installation.md
│   └── manual-fixes.md
├── hosts
│   ├── desktop.nix
│   ├── laptop.nix
│   ├── macbook.nix
│   └── rpi.nix
├── modules
│   ├── git
│   │   └── home-manager.nix
│   ├── grafana
│   ├── home-assistant
│   ├── homebridge
│   │   └── config.json
│   ├── hyprland
│   │   ├── home-manager.nix
│   │   ├── hyprland.conf
│   │   ├── wofi.css
│   │   └── waybar
│   │       ├── desktop.css
│   │       ├── desktop.json
│   │       ├── laptop.css
│   │       └── laptop.json
│   ├── mainsail
│   ├── neovim
│   │   ├── home-manager.nix
│   │   ├── init.lua
│   │   ├── vimrc
│   │   └── plugins
│   │       ├── auto-session.lua
│   │       ├── copilot-vim.lua
│   │       ├── nvim-cmp.lua
│   │       ├── nvim-lspconfig.lua
│   │       ├── nvim-spectre.lua
│   │       ├── nvim-tree-lua.lua
│   │       ├── searchbox-nvim.lua
│   │       └── telescope-nvim.lua
│   ├── nixos
│   │   └── home-manager.nix
│   ├── prometheus
│   ├── terminal
│   │   ├── home-manager.nix
│   │   ├── zellij.kdl
│   │   └── zshrc
│   ├── virtualization
│   │   ├── home-manager.nix
│   │   └── domains
│   │       └── gaming.xml
│   └── yabai
│       ├── skhdrc
│       └── yabairc
├── pkgs
│   └── bicep-ls.nix
└── scripts
    └── install.sh
```
<!--END_SECTION:tree-->

# Flake

<!--START_SECTION:flake-->
```bash
└───nixosConfigurations
    ├───desktop: NixOS configuration
    ├───laptop: NixOS configuration
    └───rpi: NixOS configuration
```
<!--END_SECTION:flake-->

