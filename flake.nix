{
  description = "Nix config files for the machines used in the intro radio";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs =
    { nixpkgs, ... }:
    {
      nixosConfigurations = {
        icecast-client = nixpkgs.lib.nixosSystem {
          modules = [
            ./icecast-client/configuration.nix
          ];
        };
        icecast-host = nixpkgs.lib.nixosSystem {
          modules = [
            ./icecast-host/configuration.nix
          ];
        };
      };
    };
}
