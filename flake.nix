{
  description = "CLI / dev batteries — reusable NixOS modules plus standalone package bundles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      # Build a `buildEnv` so the whole bundle shows up as one `nix profile` entry.
      mkEnv = pkgs: name: paths:
        pkgs.buildEnv {
          inherit name;
          paths = paths;
          pathsToLink = [ "/bin" "/share" ];
        };
    in
    {
      nixosModules = {
        dev = ./modules/dev.nix;
        base-extra = ./modules/base-extra.nix;
        wsl = ./modules/wsl.nix;
        ssh = ./modules/ssh.nix;
        podman = ./modules/podman.nix;
      };

      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          # One-shot install on a foreign system (e.g. a dev container or WSL):
          #   nix profile install github:GooseRooster/nixos-cli#base
          base = mkEnv pkgs "base" (import ./pkgs/base.nix { inherit pkgs; });
          base-extra = mkEnv pkgs "base-extra" (import ./pkgs/base-extra.nix { inherit pkgs; });
          wsl = mkEnv pkgs "wsl" (import ./pkgs/wsl.nix { inherit pkgs; });

          # `cli` and `default` are the devcontainer-safe base bundle.
          cli = self.packages.${system}.base;
          default = self.packages.${system}.base;
        });

      devShells = forAllSystems (system:
        {
          default = nixpkgs.legacyPackages.${system}.mkShell {
            packages = [ self.packages.${system}.base ];
          };
        });
    };
}
