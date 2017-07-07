# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = [
    {
    name = "nixos";
    device = "/dev/nvme0n1p2";
    preLVM = true;
    }
  ];

  fileSystems."/".options = [ "noatime" "nodiratime" "discard"];

  powerManagement.enable = true;

  networking.hostName = "varda"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    htop
    neovim
    plasma-pa
    wget
  ];

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  hardware.bluetooth.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.epson-escpr ];
  };

  # Needed to support wireless printing
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # Sound
  hardware.pulseaudio.enable = true;
  sound.mediaKeys.enable = true;
  
  # Settings needed for steam
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "gb";
    xkbOptions = "eurosign:e";

    # Enable the KDE Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    libinput = {
      enable = true;
    };

    dpi = 144;
  };

  # Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  containers = {
    tor = {
      config = 
        {config,pkgs,...}:
	{ services.tor.enable = true; };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.nc = {
    description = "Nicholas Clarke";
    isNormalUser = true;
    uid = 1000;
    extraGroups = ["wheel" "networkmanager" "docker"];
  };

  nix.binaryCaches = [
    "https://cache.nixos.org"
    "https://storage.googleapis.com/as-binary-cache-654123"
  ];
  nix.binaryCachePublicKeys = [
    "cache.alphasheets.com-1:ZAhUSf/cXThGuQE2oQjsRwE4V1G45F1MeoMQ0XZTGHs="
  ];

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
