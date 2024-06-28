{ config, pkgs, ... }:

{
    imports =
    [
        ./udev-rules.nix
    ];
}