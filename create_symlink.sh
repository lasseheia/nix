#!/usr/bin/env zsh

# The source of the symlink (the actual file)
SOURCE="/home/$USER/git/github/lasseheia/nix"

# The destination of the symlink
DESTINATION="/etc/nixos"

# Create or overwrite the symlink using sudo, as this is typically required to write to /etc/nixos/
sudo ln -sf "$SOURCE/hardware-configuration.nix" "$DESTINATION/hardware-configuration.nix"
sudo ln -sf "$SOURCE/configuration.nix" "$DESTINATION/configuration.nix"
sudo ln -sf "$SOURCE/flake.nix" "$DESTINATION/flake.nix"
sudo ln -sf "$SOURCE/flake.lock" "$DESTINATION/flake.lock"
sudo ln -sf "$SOURCE/home.nix" "$DESTINATION/home.nix"

echo "Symlinks (re)created successfully."

