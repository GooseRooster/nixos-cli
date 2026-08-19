{ config, lib, pkgs, ... }:

# Bluefin-style "batteries included" CLI tooling.
# Keep this in sync with `pkgs/base.nix` (imported below).
{
  environment.systemPackages = import ../pkgs/base.nix { inherit pkgs; };
}
