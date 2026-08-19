{ config, lib, pkgs, ... }:

# WSL dev-host extras (dev container CLI, Claude Code, opencode, fastfetch).
# No language toolchains, no GUI apps.
{
  environment.systemPackages = import ../pkgs/wsl.nix { inherit pkgs; };
}
