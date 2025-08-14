{ config, pkgs, ... }:
{
  imports = [
    ./disko.nix
    ./butt.nix
  ];

  hardware.enableAllFirmware = true;
  networking.hostName = "audio-client";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.radio = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    initialPassword = "RadioVo!";
  };

  # Beefier test VM
  virtualisation.vmVariantWithDisko.virtualisation = {
    memorySize = 8192;
    cores = 6;
  };

  nixpkgs.config.allowUnfree = true; # For Spotify
  environment.systemPackages = with pkgs; [
    butt
    carla
    spotify
    lsp-plugins
    firefox
    pulsemixer
    pavucontrol
  ];

  # Sound setup
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
  security.rtkit.enable = true;


  # Utility sound devices
  services.pipewire.extraConfig.pipewire."50-null-sinks" = {
    "context.objects" = [
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Default-Sink";
          "node.description" = "Default device; unrouted";
          "media.class" = "Audio/Sink";
          "audio.position" = "L,R";
        };
      }
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Interface-Output-Proxy";
          "node.description" = "Single interface output";
          "media.class" = "Audio/Sink";
          "audio.position" = "L,R";
        };
      }
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Interface-Input-Proxy";
          "node.description" = "Single interface input";
          "media.class" = "Audio/Sink";
          "audio.position" = "L,R";
        };
      }
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Spotify-Proxy";
          "node.description" = "Spotify should use this as output device";
          "media.class" = "Audio/Sink";
          "audio.position" = "L,R";
        };
      }
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Firefox-Proxy";
          "node.description" = "Firefox should use this as output device";
          "media.class" = "Audio/Sink";
          "audio.position" = "L,R";
        };
      }
      {
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "Teams-Proxy";
          "node.description" = "Teams should use this as output device";
          "media.class" = "Audio/Sink";
          "audio.position" = "L,R";
        };
      }
      
    ];
  };

  # Setup gnome
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;

  services.xserver.desktopManager.gnome.enable = true;

  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
}
