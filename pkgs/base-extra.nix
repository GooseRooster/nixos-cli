# Visual/misc CLI tools + GUI extras — host bootstrap only (not dev containers).
# Migrated from chezmoi's base-extra.Brewfile. Custom Homebrew-tap packages that
# have no nixpkgs equivalent were dropped: bbrew, linux-mcp-server, goose-linux.
# Note: `vscode` is unfree — set `nixpkgs.config.allowUnfree = true` (or install
# with `--impure`) when building this env standalone.
{ pkgs }:

with pkgs; [
  cava
  chafa
  fastfetch
  zk
  herdr
  lazydocker
  ramalama
  claude-code
  opencode

  vscode

  nerd-fonts."fira-code"
  nerd-fonts."jetbrains-mono"
  nerd-fonts."sauce-code-pro"
  nerd-fonts."symbols-only"
  nerd-fonts."ubuntu"
]
