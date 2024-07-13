{ config, pkgs, ... }:

{
    imports =
    [
        ./packages
        ./thunderbird
        ./vscode
        ./gtk
    ];
}