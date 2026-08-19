{ config, lib, pkgs, ... }:

# Visual/misc CLI tools + GUI extras (fonts, VS Code, fastfetch, etc).
# Host/desktop only — not for dev containers or WSL.
{
  environment.systemPackages = import ../pkgs/base-extra.nix { inherit pkgs; };
}
