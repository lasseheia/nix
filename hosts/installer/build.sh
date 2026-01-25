REPO_ROOT=$(git rev-parse --show-toplevel)
CONFIG="installer"
FLAKE_PATH="${REPO_ROOT}/hosts/${CONFIG}"

nix build ${FLAKE_PATH}#nixosConfigurations.${CONFIG}.config.system.build.isoImage
