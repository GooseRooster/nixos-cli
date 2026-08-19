# Extra CLI tooling for a WSL dev host that drives dev containers.
# Migrated from chezmoi's wsl.Brewfile. No language toolchains and no GUI apps.
{ pkgs }:

with pkgs; [
  devcontainer
  claude-code
  opencode
  fastfetch
  zk
  lazydocker
  herdr
]
