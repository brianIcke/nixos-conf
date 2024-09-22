# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [
      # Global modules
      ../global

      ./hardware-configuration.nix # Include the results of the hardware scan.

      # Optional modules
      ../optional/bluetooth
      ../optional/hyprland
      ../optional/modules/onlyoffice.nix # module by emmanuelrosa as workaround for onlyoffice using system fonts
      ../optional/docker
      ../optional/virtualization/virtualbox
      ../optional/virtualization/virt-manager
      ../optional/android-tools
    ];

  # Kernel modules
  boot.initrd.kernelModules = [ "amdgpu" ];

  # OnlyOffice
  programs.onlyoffice.enable = true;

  networking.hostName = "BrianTUX"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  users.extraGroups.networkmanager.members = [ "brian" ];

  # Firewall
  networking.firewall.allowedTCPPorts = [ 8080 1883 ];

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

  # Video driver
  services.xserver.videoDrivers = [ "amdgpu" ];

  # OpenCL utils
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
  ];

  # Vulkan support
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # Bluetooth support
  hardware.bluetooth.enable = true;

  # Steam
  programs.steam.enable = true;

  # Wireshark
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark-qt;
  users.extraGroups.wireshark.members = [ "brian" ]; # Add brian to wireshark group

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    options = "eurosign:e,caps:escape";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable virtual CUPS PDF printer.
  services.printing.cups-pdf = {
    enable = true;
    instances = {
      PDF = {
        settings = {
          Out = "\${HOME}/Dokumente/cups-pdf";
          UserUMask = "0033";
        };
      };
    };
  };

  # Enable Samba support
  services.samba.enable = true;

  # Flatpak support
  services.flatpak.enable = true;

  # Enable sound. (Pulseaudio)
  # sound.enable = true;

  # Remove sound.enable or set it to false if you had it set previously, as sound.enable is only meant for ALSA-based configurations

  # rtkit is optional but recommended
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.brian = {
    isNormalUser = true;
    initialPassword = "p@ssw0rd";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "dialout" ];
    packages = with pkgs; [
      firefox-wayland
      git
      tree
    ];
  };

  # Enable ZSH system wide
  programs.zsh.enable = true;

  # Environment variables
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Enable K3b burning utility
  programs.k3b.enable = true;
  users.extraGroups.cdrom.members = [ "brian" ]; # Add brian to cdrom group

  # Enable dconf, so GTK Themes get applied to wayland applications
  programs.dconf.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages =

    let
      #Wallpaper Engine Plugin
      # wallpaper-engine-plasma = pkgs.plasma5Packages.callPackage ./pkgs/wallpaper-engine-plasma-plugin.nix {
      #   inherit (pkgs.gst_all_1) gst-libav;
      #   inherit (pkgs.python311Packages) websockets;
      #inherit (pkgs.libsForQt5.qt5.qtwebsockets) qtwebsockets;
      # };
    in

    with pkgs; [

      ciscoPacketTracer8
      gns3-server
      anki-bin
      mpv
      inetutils
      #libsForQt5.qt5.qtwebsockets
      #wallpaper-engine-plasma
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
  system.stateVersion = "23.05"; # Did you read the comment?

}

