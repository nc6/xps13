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
    nox
    wget
  ];

  sound.mediaKeys.enable = true;

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

#   synaptics.enable = true;
#   synaptics.twoFingerScroll = true;
#   synaptics.maxSpeed = "1.5";
#   synaptics.accelFactor = "0.01";

#   synaptics.additionalOptions = ''
#     Option "VertScrollDelta" "-100"
#     Option "HorizScrollDelta" "-100"
#   '';

    dpi = 144;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.nc = {
    description = "Nicholas Clarke";
    isNormalUser = true;
    uid = 1000;
    extraGroups = ["wheel" "networkmanager"];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
