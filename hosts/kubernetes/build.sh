REPO_ROOT=$(git rev-parse --show-toplevel)
PATH="${REPO_ROOT}/hosts/kubernetes"

echo "nix build ${PATH}#nixosConfigurations.default.config.system.build.metadata --print-out-paths"
echo "nix build ${PATH}#nixosConfigurations.default.config.system.build.qemuImage --print-out-paths"
