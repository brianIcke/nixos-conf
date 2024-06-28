{ config, pkgs, ... }:

{
    # Nix flakes support
    nix.package = pkgs.nixFlakes;
    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';
}