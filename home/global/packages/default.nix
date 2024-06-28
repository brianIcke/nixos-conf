{ config, pkgs, unstable, ... }:

{
    home.packages = with pkgs; [

      unstable.AusweisApp2
      filezilla
      unstable.vesktop
      chromium
      vlc
      fzf
      zoxide
      gimp
      keepassxc
      neofetch
      libreoffice-qt
      gh
      hunspell
      hunspellDicts.de_DE
    ];
}