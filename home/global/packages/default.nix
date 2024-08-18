{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
      filezilla
      chromium
      vlc
      gimp
      keepassxc
      libreoffice
      hunspell
      hunspellDicts.de_DE
    ];
}