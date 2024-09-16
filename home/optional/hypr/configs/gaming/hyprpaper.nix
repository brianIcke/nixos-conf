{
  # Enable hyprpaper
  services.hyprpaper.enable = true;

  # Hyprpaper config
  services.hyprpaper.settings = {
    ipc = "on";
    splash = false;
    splash_offset = 2.0;

    preload =
      [ "~/.wallpapers/arch-linux-chan-wallpaper.jpg" ];

    wallpaper = [
      "DP-2,~/.wallpapers/arch-linux-chan-wallpaper.jpg"
      "DP-3,~/.wallpapers/arch-linux-chan-wallpaper.jpg"
    ];
  };
}
