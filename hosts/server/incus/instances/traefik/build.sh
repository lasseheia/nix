REPO_ROOT=$(git rev-parse --show-toplevel)
FLAKE="${REPO_ROOT}/hosts/traefik#default"

nixos-rebuild build-image --flake $FLAKE --image-variant lxc-metadata
nixos-rebuild build-image --flake $FLAKE --image-variant lxc
