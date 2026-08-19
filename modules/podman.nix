{ config, lib, pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages = with pkgs; [
    podman-compose
  ];

  # Declarative *system* quadlets live in /etc/containers/systemd/.
  # For an example, see quadlets/example.container. Declare one like this:
  #
  #   environment.etc."containers/systemd/example.container".source =
  #     ../quadlets/example.container;
  #
  # Rootless *user* quadlets live in ~/.config/containers/systemd/
  # and are typically managed with chezmoi.
}
