{ config, pkgs, ... }:

{
    imports =
    [
        ./bootloader.nix
        ./supported-fs.nix
    ];
}