{
  config,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    ./disko.nix
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Qemu guest agent
  services.qemuGuest.enable = true;

  users.users.radio = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    initialPassword = "RadioVo!";
  };

  # Icecast
  services.icecast = {
    enable = true;
    admin.password = "test";
    hostname = "localhost";
    listen.address = "0.0.0.0";
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8000 ];
  };

  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
}
