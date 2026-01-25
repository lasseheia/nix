REPO_ROOT=$(git rev-parse --show-toplevel)
CONFIG="home-assistant"
FLAKE_PATH="${REPO_ROOT}/hosts/${CONFIG}"
USER="root"
IP_ADDRESS="10.0.0.171"
NIX_SSHOPTS="-p 8890"

nixos-rebuild switch \
  --flake ${FLAKE_PATH}#${CONFIG} \
  --target-host ${USER}@${IP_ADDRESS} \
  --build-host ${USER}@${IP_ADDRESS} \
  --fast # Build on the target host to match the target architecture
