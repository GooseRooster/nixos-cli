#!/usr/bin/env bash
# Dev container — personal setup (runs after the baseline setup-repo.sh).
# Installs Nix (kept out of the shared image), the nix-cli CLI bundle, your
# Home Manager dotfiles, and the lazydotnet.nvim companion CLIs. Lives in the
# gitignored .devcontainer/local/, so it's entirely yours.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
[ -f "$here/config.sh" ] && source "$here/config.sh"
: "${NIX_CLI_FLAKE:?set NIX_CLI_FLAKE in .devcontainer/local/config.sh}"
: "${DOTFILES_FLAKE:?set DOTFILES_FLAKE in .devcontainer/local/config.sh}"

# 1) Nix — not baked into the shared image; personalization brings its own.
#    Multi-user install (passwordless sudo via the common-utils feature).
if ! command -v nix >/dev/null 2>&1; then
  curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes
fi
if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# 2) CLI "batteries" (nushell, neovim, yazi, …) via plain Nix.
nix --extra-experimental-features 'nix-command flakes' \
  profile install "$NIX_CLI_FLAKE#base"

# 3) Home Manager dotfiles (nushell config, LazyVim, yazi). `--impure` lets
#    hosts/devcontainer.nix read the real $USER/$HOME (the dotnet image's
#    uid-1000 user is 'ubuntu', not 'vscode').
nix --extra-experimental-features 'nix-command flakes' \
  run github:nix-community/home-manager/master \
  -- switch --flake "$DOTFILES_FLAKE#devcontainer" --impure

# 4) lazydotnet.nvim companion CLIs (land in ~/.dotnet/tools, already on PATH).
#    dotnet-outdated-tool powers lazydotnet's NuGet-package (outdated) feature.
dotnet tool install --global lazydotnet
dotnet tool install --global dotnet-outdated-tool

# 5) Git identity, so commits from inside the container have an author.
[ -n "${GIT_USER_NAME:-}" ]  && git config --global user.name  "$GIT_USER_NAME"
[ -n "${GIT_USER_EMAIL:-}" ] && git config --global user.email "$GIT_USER_EMAIL"
