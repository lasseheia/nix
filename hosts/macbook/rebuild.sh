REPO_ROOT=$(git rev-parse --show-toplevel)
CONFIG="macbook"
FLAKE_PATH="${REPO_ROOT}/hosts/${CONFIG}"

sudo darwin-rebuild switch \
  --flake ${FLAKE_PATH}#${CONFIG} \
