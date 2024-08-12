{ config, pkgs, unstable, ... }:

{
    home.packages = with pkgs; [

      unstable.AusweisApp2
      filezilla
      unstable.vesktop
      chromium
      vlc
      gimp
      keepassxc
      libreoffice
      hunspell
      hunspellDicts.de_DE
    ];
}