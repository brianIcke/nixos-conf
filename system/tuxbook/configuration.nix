# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable plymouth
  boot.plymouth.enable = true;

  # NTFS support
  boot.supportedFilesystems = [ "ntfs" ];

  # VirtualBox support
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "brian" ];

  # VirtualBox extensions
  virtualisation.virtualbox.host.enableExtensionPack = true;

  # Nix flakes support
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  networking.hostName = "tuxbook"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.supportedLocales = [
    "de_DE.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # XDG desktop integration
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
       xdg-desktop-portal-wlr
       xdg-desktop-portal-gtk
     ];
    };
  };

  # Fonts
  fonts.fonts = with pkgs; [
  font-awesome
  powerline-fonts
  powerline-symbols
  (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  # Bluetooth support
  hardware.bluetooth.enable = true;

  # Enable SDDM display manager
  #services.xserver.displayManager.sddm.enable = true;

  # Enable LightDM display manager
  #services.xserver.displayManager.lightdm.enable = true;

  # Enable GDM display manager
  servives.xserver.displayManager.gdm.enable = true;

  # Enable Budgie Desktop
  services.xserver.desktopManager.budgie.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  #services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "de";
  services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable daemon for fingerprint reader
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Remove sound.enable or set it to false if you had it set previously, as sound.enable is only meant for ALSA-based configurations

  # Pipewire support
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # Bluetooth codecs
  environment.etc = {
	"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
		bluez_monitor.properties = {
			["bluez5.enable-sbc-xq"] = true,
			["bluez5.enable-msbc"] = true,
			["bluez5.enable-hw-volume"] = true,
			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		}
	'';
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.brian = {
    isNormalUser = true;
    initialPassword = "p@ssw0rd";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      git
      tree
    ];
  };


  # Environment variables
  #environment.sessionVariables = {
  #};

  # Enable ZSH system-wide
  programs.zsh.enable = true;

  # Enable tmux system-wide
  programs.tmux.enable = true;

  # Neovim configuration
  #programs.nixvim = {
  #  enable = true;
  #  colorschemes.tokyonight.enable = true;
  #};

  # Enable Yubikey support for GPG and SSH
  services.udev.packages = [ pkgs.yubikey-personalization ];
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages =

  let
    # Python packages
    python-packages = ps: with ps; [
      pandas
      numpy
    ];
  in

  with pkgs; [
    alacritty
    vim 
    wget
    curl
    (python311.withPackages python-packages)
    jdk17
    jetbrains.idea-community
    nmap
    bat
    htop
    xclip
    alsa-utils
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

