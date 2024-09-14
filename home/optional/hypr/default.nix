{ config, pkgs, ... }:

{
    imports =
    [
        ./hyprland.nix
        ./hypridle.nix
        ./hyprpaper.nix
    ];
}