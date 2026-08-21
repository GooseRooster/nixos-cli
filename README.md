# nix-cli

CLI / dev "batteries" (Bluefin-style) in their own flake so they can be reused
on a NixOS system **and** on a foreign system (e.g. a dev container or WSL) via
plain Nix.

## Consumers

### NixOS (via `nixos-config`)

Add as a flake input, then import the modules you want:

```nix
imports = [
  inputs.cli.nixosModules.dev        # base CLI tools
  inputs.cli.nixosModules.base-extra # visual/GUI host extras (desktop only)
  inputs.cli.nixosModules.wsl        # WSL dev-host extras
  inputs.cli.nixosModules.ssh
  inputs.cli.nixosModules.podman
];
```

### Foreign system (dev container / WSL)

The bundles are granular, so a dev container installs just the lean base set:

```sh
# dev container — base CLI tools only
nix profile install github:GooseRooster/nix-cli#base

# WSL — base + WSL extras
nix profile install github:GooseRooster/nix-cli#base github:GooseRooster/nix-cli#wsl

# full desktop host extras (visual/GUI, fonts, VS Code)
nix profile install github:GooseRooster/nix-cli#base-extra
```

Or drop into a shell:

```sh
nix develop github:GooseRooster/nix-cli
```

> `#base-extra` includes `vscode`, which is unfree. Install it with
> `--impure` or set `nixpkgs.config.allowUnfree = true` in your nix config.

## Layout

- `pkgs/base.nix` — base CLI tools (from `base.Brewfile`), devcontainer-safe
- `pkgs/base-extra.nix` — visual/misc + GUI extras (from `base-extra.Brewfile`)
- `pkgs/wsl.nix` — WSL dev-host extras (from `wsl.Brewfile`)
- `modules/dev.nix` — the same base list as a NixOS module
- `modules/base-extra.nix` — base-extra list as a NixOS module
- `modules/wsl.nix` — wsl list as a NixOS module
- `modules/ssh.nix` — openssh + persistent user ssh-agent
- `modules/podman.nix` — rootless podman (+ docker compat) and quadlet guidance
- `quadlets/` — example podman quadlet files
- `devcontainer-templates/` — ready-to-copy `.devcontainer` scaffolding (base,
  dotnet, ci-compose). Their personalization hooks install Nix + `#base` +
  Home Manager dotfiles. Fetch without cloning:
  `nix build --no-link --print-out-paths github:GooseRooster/nix-cli#devcontainer-templates`

The `pkgs/*.nix` files are `{ pkgs }: [ ... ]` functions shared by both the
flake's `buildEnv` packages and the NixOS modules, so the two never drift.

## Cheatsheet

```sh
# Build a bundle locally (sanity check)
nix build .#base
nix build .#base-extra
nix build .#wsl

# Update flake inputs
nix flake update

# Sanity-check the flake
nix flake check

# Install a bundle on a foreign system (dev container / WSL)
nix profile install github:GooseRooster/nix-cli#base
nix profile install github:GooseRooster/nix-cli#base github:GooseRooster/nix-cli#wsl

# Upgrade installed bundles (pin the profile to a fresh flake ref)
nix profile upgrade '.*'

# See what's installed and remove an entry
nix profile list
nix profile remove <index>

# Drop into a shell with the base bundle on PATH (no install)
nix develop github:GooseRooster/nix-cli

# Find a package's nixpkgs attribute name before adding it to pkgs/*.nix
nix search nixpkgs <name>
```
