{
  # Enable hyprpaper
  services.hyprpaper.enable = true;

  # Hyprpaper config
  services.hyprpaper.settings = {
    ipc = "on";
    splash = false;
    splash_offset = 2.0;

    preload =
      [ "~/Bilder/arch-linux-chan-wallpaper.jpg" ];

    wallpaper = [
      "DP-2,~/Bilder/arch-linux-chan-wallpaper.jpg"
      "DP-3,~/Bilder/arch-linux-chan-wallpaper.jpg"
    ];
  };
}
