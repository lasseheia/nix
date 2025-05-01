REPO_ROOT=$(git rev-parse --show-toplevel)
CONFIG="desktop"
USER="nixos"
IP_ADDRESS="192.168.1.10"

nix run github:nix-community/nixos-anywhere/9afe1f9fa36da6075fdbb48d4d87e63456535858 -- \
  --flake ${REPO_ROOT}#${CONFIG} \
  --target-host ${USER}@${IP_ADDRESS}
