{
  # Enable hyprpaper
  services.hyprpaper.enable = true;

  # Hyprpaper config
  services.hyprpaper.settings = {
    ipc = "on";
    splash = false;
    splash_offset = 2.0;

    preload =
      [ "~/.wallpapers/pixel_art_city.jpg" ];

    wallpaper = [
      "DP-3,~/.wallpapers/pixel_art_city.jpg"
      "DP-4,~/.wallpapers/pixel_art_city.jpg"
    ];
  };
}
