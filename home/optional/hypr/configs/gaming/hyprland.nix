{ config, ... }:
{

  # Enable hyprland module
  wayland.windowManager.hyprland.enable = true;

  # Enable udiskie
  services.udiskie.enable = true;

  # Enable dunst notification daemon
  services.dunst.enable = true;

  # Hyprland config
  wayland.windowManager.hyprland.settings = {
    source = "${config.home.homeDirectory}/.config/hypr/mocha.conf";

    # Set used programs
    "$terminal" = "alacritty";
    "$fileManager" = "thunar";
    "$menu" = "wofi --show drun";

    # Autostart
    "exec-once" = [
      "$terminal &"
      "nm-applet &"
      "copyq --start-server &"
      "[workspace 1] firefox &"
      "thunderbird &"
    ];

    # Environment variables
    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];

    # Look and feel
    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;

      # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
      "col.active_border" = "rgba($tealAlphaee) rgba($overlay1Alphaee) 45deg";
      "col.inactive_border" = "rgba($surface2Alphaaa)";

      # Set to true enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = false;

      layout = "dwindle";
    };

    # https://wiki.hyprland.org/Configuring/Variables/#decoration
    decoration = {
      rounding = 10;

      # Change transparency of focused and unfocused windows
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";

      # https://wiki.hyprland.org/Configuring/Variables/#blur
      blur = {
        enabled = true;
        size = 3;
        passes = 1;

        vibrancy = 0.1696;
      };
    };

    # https://wiki.hyprland.org/Configuring/Variables/#animations
    animations = {
      enabled = true;

      # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    dwindle = {
      pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true; # You probably want this
    };

    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    master = {
      new_status = "master";
    };

    # https://wiki.hyprland.org/Configuring/Variables/#misc
    misc = {
      force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
      disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
    };

    # https://wiki.hyprland.org/Configuring/Variables/#input
    input = {
      kb_layout = "us,de";
      kb_variant = ",qwerty";

      follow_mouse = 1;

      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

      touchpad = {
        natural_scroll = false;
      };
    };

    # https://wiki.hyprland.org/Configuring/Variables/#gestures
    gestures = {
      workspace_swipe = false;
    };

    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
    device = {
      name = "logitech-advanced-corded-mouse-m500s";
      sensitivity = -0.5;
    };

    #################
    ###KEYBINDINGS###
    #################

    # See https://wiki.hyprland.org/Configuring/Keywords/

    # Set mainModifier key
    "$mainMod" = "SUPER";

    # Set subModifier key (programs+workspaces)
    "$subMod" = "$mainMod+SHIFT";

    # Set powerModifier key (power)
    "$powerMod" = "Control_L&Alt_L";

    bind = [
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      "$mainMod, Q, exec, pgrep $terminal || $terminal"
      "$mainMod, C, killactive,"
      "$mainMod, M, exit,"
      "$mainMod, L, exec, hyprlock"
      "$mainMod, F, exec, $fileManager"
      "$mainMod, N, exec, codium $HOME/.nix-conf"
      "$mainMod, V, togglefloating,"
      "$mainMod, return, fullscreen"
      "$mainMod, R, exec, $menu"
      "$mainMod, E, exec, wofi-emoji"
      "$mainMod, P, pseudo,"
      "$mainMod, J, togglesplit,"
      "$mainMod, space, exec, hyprctl switchxkblayout keychron-q2 next"

      # Screenshots (Hyprshot)
      "$mainMod, X, exec, hyprshot -m region"
      "$subMod, X, exec, hyprshot -m window"
      "$mainMod, O, exec, hyprshot -m output"

      # Media keys
      ",XF86AudioMute, exec, pactl set-sink-mute 0 toggle"
      ",XF86AudioLowerVolume, exec, pactl set-sink-volume 0 -2%"
      ",XF86AudioRaiseVolume, exec, pactl set-sink-volume 0 +2%"

      # Move focus with mainMod + arrow keys
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Workspaces
      "$mainMod, T, workspace, name:thunderbird"
      "$subMod, D, workspace, name:discord"
      "$subMod, S, workspace, name:steam"
      "$subMod, G, workspace, name:game"
      "$mainMod, Q, workspace, name:terminal"

      # Special workspaces
      "$subMod, H, togglespecialworkspace, magic"

      # Applications
      "$subMod, F, exec, firefox"
      "$subMod, D, exec, pgrep vesktop || vesktop"
      "$subMod, S, exec, pgrep steam || steam"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
    ]
    ++ (
      # workspaces
      # binds $mainMod + [shift +] {1..10} to [move to] workspace {1..10}
      builtins.concatLists (builtins.genList
        (
          x:
          let
            ws =
              let
                c = (x + 1) / 10;
              in
              builtins.toString (x + 1 - (c * 10));
          in
          [
            "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
            "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        )
        10)
    );

    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    binds = [
      # Power options
      "$powerMod, P, exec, systemctl poweroff"
      "$powerMod, R, exec, systemctl reboot"
      "$powerMod, L, exec, hyprlock"
    ];

    ##############################
    ### WINDOWS AND WORKSPACES ###
    ##############################

    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
    # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

    workspace = [
      "name:thunderbird,monitor:DP-3"
      "name:discord,monitor:DP-3"
      "name:steam,monitor:DP-3"
      "name:game,monitor:DP-2, border:false, rounding:false"
      "name:terminal,monitor:DP-3"
    ];

    windowrulev2 = [
      "workspace name:terminal, class:Alacritty"
      "workspace name:thunderbird, class:thunderbird"
      "workspace name:discord, class:vesktop"
      "workspace name:steam silent, class:steam"
      "workspace name:game, class:^steam_app_\\\d+$"
      "fullscreen, class:^steam_app_\\\d+$"
      "suppressevent maximize, class:.*"
    ];

  };

}
