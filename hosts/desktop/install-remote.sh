REPO_ROOT=$(git rev-parse --show-toplevel)
CONFIG="desktop"
USER="nixos"
IP_ADDRESS="192.168.1.10"

nixos-anywhere \
  --flake ${REPO_ROOT}#${CONFIG} \
  --target-host ${USER}@${IP_ADDRESS}
