{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
      filezilla
      chromium
      gimp
      keepassxc
      libreoffice
      hunspell
      hunspellDicts.de_DE
    ];
}