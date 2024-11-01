{ config, pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland.enable = true;

  # Enable waybar
  programs.waybar.enable = true;

  # Enable SDDM display manager
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };

  # Enable Udisk2 service
  services.udisks2.enable = true;

  # Enable Thunar file manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  };

  # Essential packages
  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override
      {
        flavor = "mocha";
        font = "Noto Sans";
        fontSize = "9";
        background = "${config.users.users.brian.home}/.wallpapers/cat-wallpaper.png";
        loginBackground = true;
      })

    networkmanagerapplet
    hyprshot
    wofi
    wofi-emoji
    copyq
  ];
}
