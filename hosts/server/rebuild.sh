REPO_ROOT=$(git rev-parse --show-toplevel)
CONFIG="server"
FLAKE_PATH="${REPO_ROOT}/hosts/${CONFIG}"

sudo nixos-rebuild switch \
  --flake ${FLAKE_PATH}#${CONFIG}
