{ config, pkgs, ... }:

{
    imports =
    [
        ./flakes-support.nix
        ./packages.nix
        ./overlays.nix
    ];
}