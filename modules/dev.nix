{ config, lib, pkgs, ... }:

# Bluefin-style "batteries included" CLI tooling.
# Keep this list in sync with the `cli` package in ../flake.nix.
{
  environment.systemPackages = with pkgs; [
    git
    git-lfs
    gh
    just
    direnv
    gcc
    binutils
    gnumake
    pkg-config
    ripgrep
    fd
    bat
    eza
    fzf
    jq
    yq-go
    htop
    btop
    tree
    unzip
    zip
    p7zip
    curl
    wget
    gnupg
    tmux
    tealdeer
  ];
}
