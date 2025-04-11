REPO_ROOT=$(git rev-parse --show-toplevel)
CONFIG="desktop"

sudo nixos-rebuild switch \
  --flake ${REPO_ROOT}#${CONFIG}
