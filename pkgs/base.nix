# Base CLI tooling — devcontainer-safe, no GUI/visual extras.
# Migrated from chezmoi's base.Brewfile. Kept as a `pkgs -> [ ... ]`
# function so both `flake.nix` (buildEnv) and `modules/dev.nix`
# (systemPackages) share one source of truth.
{ pkgs }:

with pkgs; [
  bat
  carapace
  chezmoi
  dust
  dysk
  eza
  fd
  gcc
  ffmpeg-full
  fish
  fzf
  gh
  delta
  imagemagick
  jq
  lazygit
  neovim
  nushell
  p7zip
  pipx
  poppler-utils
  resvg
  ripgrep
  starship
  tealdeer
  television
  trash-cli
  tree-sitter
  uutils-coreutils
  yazi
  zip
  zoxide
  unzip
  nodejs
  file
  shellcheck
  stylua
  resterm
]
