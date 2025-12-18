REPO_ROOT=$(git rev-parse --show-toplevel)
CONFIG="server"
USER="root"
IP_ADDRESS="10.0.0.171"

nixos-rebuild switch \
  --flake ${REPO_ROOT}#${CONFIG} \
  --target-host ${USER}@${IP_ADDRESS} \
  --build-host ${USER}@${IP_ADDRESS} \
  --fast # Build on the target host to match the target architecture
