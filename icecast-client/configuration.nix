{ config, pkgs, ... }:
{
  imports = [
    ./disko.nix
  ];

  networking.hostName = "radio-audio-client";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.radio = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    initialPassword = "RadioVo!";
  };

  environment.systemPackages = with pkgs; [
    butt
  ];

  sops.defaultSopsFile = ./secrets/example.yaml;
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;
  sops.secrets.example-key = {};
  sops.secrets."myservice/my_subdir/my_secret" = {};

  # Setup gnome
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;

  services.xserver.desktopManager.gnome.enable = true;

  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
}
