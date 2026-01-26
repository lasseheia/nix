REPO_ROOT=$(git rev-parse --show-toplevel)
CONFIG="laptop"
FLAKE_PATH="${REPO_ROOT}/hosts/${CONFIG}"

sudo nixos-rebuild switch \
  --flake ${FLAKE_PATH}#${CONFIG}
