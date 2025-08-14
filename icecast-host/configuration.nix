{
  config,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    ./disko.nix
    ./icecast.nix
    "${modulesPath}/profiles/qemu-guest.nix"

  ];

  networking.hostName = "icecast-host";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Qemu guest agent
  services.qemuGuest.enable = true;

  sops.secrets."user_password" = {
    neededForUsers = true;
  };
  users.users.radio = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    hashedPasswordFile = config.sops.secrets."user_password".path;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8000 ];
  };

  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";

  # enable ssh
  services.openssh.enable = true;
}
