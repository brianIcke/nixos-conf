{ config, pkgs, ... }:

{
    imports =
    [
        ./boot
        ./nixpkgs
        ./i18n
        ./fonts
        ./yubikey
    ];
}