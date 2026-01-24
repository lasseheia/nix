REPO_ROOT=$(git rev-parse --show-toplevel)
CONFIG="server"
FLAKE_PATH="${REPO_ROOT}/hosts/${CONFIG}"
USER="nixos"
IP_ADDRESS="10.0.0.171"

nix run github:nix-community/nixos-anywhere -- \
  --flake ${FLAKE_PATH}#${CONFIG} \
  --target-host ${USER}@${IP_ADDRESS}
