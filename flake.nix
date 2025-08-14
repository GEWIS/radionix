{
  description = "Nix config files for the machines used in the intro radio";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    # Disko for declarative disk management
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    { nixpkgs, disko, sops-nix, ... }:
    {
      nixosConfigurations = {
        audio-client = nixpkgs.lib.nixosSystem {
          modules = [
            ./audio-client/configuration.nix
            disko.nixosModules.default
            sops-nix.nixosModules.sops
            {
              sops = {
                defaultSopsFile = ./secrets/secrets.yaml;
                age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
              };
            }
          ];
        };
        icecast-host = nixpkgs.lib.nixosSystem {
          modules = [
            ./icecast-host/configuration.nix
            disko.nixosModules.default
            sops-nix.nixosModules.sops
            {
              sops = {
                defaultSopsFile = ./secrets/secrets.yaml;
                age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
              };
            }
          ];
        };
      };
    };
}
