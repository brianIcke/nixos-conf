# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Global modules
      ../global

      # Optional modules
      ../optional/virtualization/virt-manager
    ];

  # Enable plymouth
  boot.plymouth.enable = true;

  # Enable bootspec
  boot.bootspec.enable = true;

  # Enable systemd-boot initrd
  boot.initrd.systemd.enable = true;

  # LUKS
  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/13cae5b6-3e28-44bd-ac14-35693fc1fed3";

  ## Yubikey U2F PAM
  #security.pam.u2f = {
  #  enable = true;
  #  control = "required";
  #  cue = true;
  #};

  networking.hostName = "IVV7BRIAN"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable SDDM display manager
  #services.displayManager.sddm.enable = true;

  # Enable GDM display manager
  services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.gdm.debug = true;

  # Enable GNOME Desktop
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de,us";
    options = "eurosign:e,caps:escape";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # Remove sound.enable or set it to false if you had it set previously, as sound.enable is only meant for ALSA-based configurations

  # Flatpak support
  services.flatpak.enable = true;

  # rtkit is optional but recommended
  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.brian = {
    isNormalUser = true;
    initialPassword = "p@ssw0rd";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "libvirtd" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox-wayland
      git
      tree
    ];
  };


  # Environment variables
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs;
  [
     mattermost-desktop 
     jetbrains.idea-community-bin
     virt-viewer
     freerdp3
     remmina
     gnomeExtensions.remmina-search-provider
     gnome.gnome-tweaks
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

