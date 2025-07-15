{
  description = "Nix config files for the machines used in the intro radio";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    # Disko for declarative disk management
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, disko, ... }:
    {
      nixosConfigurations = {
        icecast-client = nixpkgs.lib.nixosSystem {
          modules = [
            ./icecast-client/configuration.nix
            disko.nixosModules.default
          ];
        };
        icecast-host = nixpkgs.lib.nixosSystem {
          modules = [
            ./icecast-host/configuration.nix
            disko.nixosModules.default
          ];
        };
      };
    };
}
