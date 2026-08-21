# Personal dev container setup (optional)

This dev container works out of the box with no personal setup. This directory is
a template for layering your own environment (dotfiles, editor, tooling) on top —
it never affects teammates or CI.

## Use it

    cp -r .devcontainer/local.example .devcontainer/local
    # edit .devcontainer/local/config.sh (NIX_CLI_FLAKE / DOTFILES_FLAKE + your git name/email)
    # rebuild the container

`.devcontainer/local/` is gitignored (see `.devcontainer/.gitignore`).
`scripts/setup-local.sh` runs `local/setup.sh` at the end of container creation if
it exists; otherwise nothing happens.

## What the template does
- installs Nix (kept out of the shared image),
- installs the nix-cli CLI bundle (`NIX_CLI_FLAKE`) via `nix profile install`,
- applies your Home Manager dotfiles (`DOTFILES_FLAKE`) with the lean #devcontainer flavor,
- installs the `lazydotnet` / `dotnet-outdated` CLIs used by `lazydotnet.nvim`,
- sets your git identity (`GIT_USER_NAME` / `GIT_USER_EMAIL`) — SSH auth itself is
  the forwarded agent, so no keys are needed here.

Edit `local/setup.sh` freely — it's yours.
