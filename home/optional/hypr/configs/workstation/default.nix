{ config, pkgs, ... }:

{
    imports =
    [
        ./hyprland.nix
        ./hyprpaper.nix
        ./kanshi.nix
        ../hypridle.nix
    ];
}