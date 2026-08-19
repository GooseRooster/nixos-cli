{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.openssh ];

  # Persistent user ssh-agent (systemd user service).
  programs.ssh.startAgent = true;
}
