REPO_ROOT=$(git rev-parse --show-toplevel)
CONFIG="macbook"

sudo darwin-rebuild switch \
  --flake ${REPO_ROOT}#${CONFIG}
