#!/usr/bin/env zsh

# The source of the symlink (the actual file)
SOURCE="/home/$USER/git/github/lasseheia/nix/configuration.nix"

# The destination of the symlink
DESTINATION="/etc/nixos/configuration.nix"

# Create or overwrite the symlink using sudo, as this is typically required to write to /etc/nixos/
sudo ln -sf "$SOURCE" "$DESTINATION"

echo "Symlink (re)created successfully."

