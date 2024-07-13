{ config, pkgs, ... }:
{
# GTK settings
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
    cursorTheme = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
    };
  };
}