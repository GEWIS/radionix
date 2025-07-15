{ config, pkgs, ... }:
{
  imports = [
    ./disko.nix
  ];

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

  # Setup gnome
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;

  services.xserver.desktopManager.gnome.enable = true;

  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
}
