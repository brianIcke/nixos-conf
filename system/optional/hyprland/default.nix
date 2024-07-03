{ config, pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland.enable = true;

  # Enable hyprlock (screen-lock)
  programs.hyprlock.enable = true;

  # Enable hypridle (idle daemon)
  services.hypridle.enable = true;

  # Enable SDDM display manager
  services.displayManager.sddm.enable = true;

  # Enable Udisk2 service
  services.udisks2.enable = true;

  # Essential packages
  environment.systemPackages = with pkgs; [
    udiskie
    dunst
    dolphin
    networkmanagerapplet
    hyprpaper
    wofi
    wofi-emoji
    waybar
    copyq
  ]; 
}