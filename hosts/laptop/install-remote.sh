REPO_ROOT=$(git rev-parse --show-toplevel)
CONFIG="laptop"
USER="nixos"
IP_ADDRESS="10.0.0.197"

nixos-anywhere \
  --flake ${REPO_ROOT}#${CONFIG} \
  --target-host ${USER}@${IP_ADDRESS} \
  --build-on remote
