REPO_ROOT=$(git rev-parse --show-toplevel)
CONFIG="server"
USER="nixos"
IP_ADDRESS="192.168.1.206"
#IP_ADDRESS="10.20.10.63"

nix run github:nix-community/nixos-anywhere -- \
  --flake ${REPO_ROOT}#${CONFIG} \
  --target-host ${USER}@${IP_ADDRESS}
