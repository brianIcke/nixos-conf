{ config, pkgs, ... }:

{
    imports =
    [
        ./boot
        ./terminal
        ./nixpkgs
        ./i18n
        ./fonts
        ./yubikey
        ./pipewire
        ./avahi
        ./java
    ];
}