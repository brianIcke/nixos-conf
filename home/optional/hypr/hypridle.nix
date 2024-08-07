{
  # Enable hyprlock (screen-lock)
  programs.hyprlock.enable = true;

  # Enable hypridle (idle daemon)
  services.hypridle.enable = true;

  # Hypridle configuration
  services.hypridle.settings = {
    general = {
      lock_cmd = "pidof hyprlock || hyprlock";       # avoid starting multiple hyprlock instances.
      before_sleep_cmd = "loginctl lock-session";    # lock before suspend.
      after_sleep_cmd = "hyprctl dispatch dpms on";  # to avoid having to press a key twice to turn on the display.
    };

    listener = [
      {
        timeout = 300;                                   # 5min
        on-timeout = "loginctl lock-session";            # lock screen when timeout has passed
      }

      {
        timeout = 330;                                   # 5.5min
        on-timeout = "hyprctl dispatch dpms off";        # screen off when timeout has passed
        on-resume = "hyprctl dispatch dpms on";          # screen on when activity is detected after timeout has fired.
      }

      {
        timeout = 1800;                                  # 30min
        on-timeout = "systemctl suspend";                # suspend pc
      }
    ];
  };
}