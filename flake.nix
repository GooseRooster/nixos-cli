{
  description = "CLI / dev batteries — reusable NixOS modules plus a standalone package bundle";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      nixosModules = {
        dev = ./modules/dev.nix;
        ssh = ./modules/ssh.nix;
        podman = ./modules/podman.nix;
      };

      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          # One-shot install on a foreign system (e.g. Ubuntu/WSL):
          #   nix profile install github:<you>/nixos-cli#cli
          cli = pkgs.buildEnv {
            name = "cli";
            paths = with pkgs; [
              git
              git-lfs
              gh
              just
              direnv
              gcc
              binutils
              gnumake
              pkg-config
              ripgrep
              fd
              bat
              eza
              fzf
              jq
              yq-go
              htop
              btop
              tree
              unzip
              zip
              p7zip
              curl
              wget
              openssh
              gnupg
              tmux
              tealdeer
            ];
          };
          default = self.packages.${system}.cli;
        });

      devShells = forAllSystems (system:
        {
          default = nixpkgs.legacyPackages.${system}.mkShell {
            packages = [ self.packages.${system}.cli ];
          };
        });
    };
}
