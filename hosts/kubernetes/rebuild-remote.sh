REPO_ROOT=$(git rev-parse --show-toplevel)
FLAKE="${REPO_ROOT}/hosts/kubernetes#default"
HOST="root@10.0.0.171"

NIX_SSHOPTS="-p 2222" nixos-rebuild switch \
  --flake $FLAKE \
  --target-host $HOST \
  --build-host $HOST
