{ config, pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland.enable = true;

  # Enable waybar
  programs.waybar.enable = true;

  # Enable SDDM display manager
  services.displayManager.sddm.enable = true;

  # Enable Udisk2 service
  services.udisks2.enable = true;

  # Enable Thunar file manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  };

  # Essential packages
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    wofi
    wofi-emoji
    copyq
  ]; 
}