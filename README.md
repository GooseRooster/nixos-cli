# nixos-cli

CLI / dev "batteries" (Bluefin-style) in their own flake so they can be reused
on a NixOS system **and** on a foreign system (e.g. Ubuntu/WSL) via plain Nix.

## Consumers

### NixOS (via `nixos-config`)

Add as a flake input, then import the modules you want:

```nix
imports = [
  inputs.cli.nixosModules.dev
  inputs.cli.nixosModules.ssh
  inputs.cli.nixosModules.podman
];
```

### Foreign system (Ubuntu/WSL)

```sh
nix profile install github:<you>/nixos-cli#cli
```

Or drop into a shell:

```sh
nix develop github:<you>/nixos-cli
```

## Layout

- `modules/dev.nix` — git, just, direnv, build toolchain, common dev deps
- `modules/ssh.nix` — openssh + persistent user ssh-agent
- `modules/podman.nix` — rootless podman (+ docker compat) and quadlet guidance
- `quadlets/` — example podman quadlet files
