# Dev container — personal config.
#
# Copy this whole directory up one level to .devcontainer/local/ (gitignored):
#
#     cp -r .devcontainer/local.example .devcontainer/local
#
# Edit the values below, then rebuild the container. local/setup.sh sources this.

# nix-cli flake to install via `nix profile install` (the CLI "batteries").
NIX_CLI_FLAKE="github:GooseRooster/nix-cli"

# Home Manager dotfiles flake to apply (the lean #devcontainer flavor).
DOTFILES_FLAKE="github:GooseRooster/home-manager"

# Git identity for commits made inside the container (written to ~/.gitconfig;
# SSH auth is handled by the forwarded agent). Leave either empty to skip.
GIT_USER_NAME=""
GIT_USER_EMAIL=""
