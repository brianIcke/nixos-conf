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
      "$terminal"
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
      gaps_out = 20;
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
      kb_layout = "de,us";
      kb_variant = ",qwertz";

      follow_mouse = 1;

      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

      touchpad = {
        natural_scroll = true;
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

    # Set modifier key
    "$mod" = "SUPER";

    # Set modifier key (programs+workspaces)
    "$subMod" = "$mod+SHIFT";

    # Set modifier key (power)
    "$powerMod" = "$mod+Alt_L";

    bind = [
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      "$mod, Q, exec, pgrep $terminal || $terminal"
      "$mod, C, killactive,"
      "$mod, M, exit,"
      "$mod, L, exec, hyprlock"
      "$mod, F, exec, $fileManager"
      "$mod, N, exec, codium $HOME/.nix-conf"
      "$mod, V, togglefloating,"
      "$mod, return, fullscreen"
      "$mod, R, exec, $menu"
      "$mod, E, exec, wofi-emoji"
      "$mod, P, pseudo,"
      "$mod, J, togglesplit,"
      "$mod, space, exec, hyprctl switchxkblayout keychron-q2 next"

      # Media keys
      ",XF86AudioMute, exec, pactl set-sink-mute 0 toggle"
      ",XF86AudioLowerVolume, exec, pactl set-sink-volume 0 -2%"
      ",XF86AudioRaiseVolume, exec, pactl set-sink-volume 0 +2%"

      # Move focus with mod + arrow keys
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      # Workspaces
      "$subMod, T, workspace, name:thunderbird"
      "$subMod, D, workspace, name:discord"
      "$subMod, Q, workspace, name:terminal"

      # Special workspaces
      "$subMod, H, togglespecialworkspace, magic"

      # Applications
      "$subMod, F, exec, firefox"
      "$subMod, D, exec, pgrep vesktop || vesktop"

      # Scroll through existing workspaces with mod + scroll
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
    ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
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
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        )
        10)
    );

    bindm = [
      # Move/resize windows with mod + LMB/RMB and dragging
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    binds = [
      # Power options
      "$powerMod, P, exec, systemctl poweroff"
      "$powerMod, R, exec, systemctl reboot"
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
      "workspace name:thunderbird, class:thunderbird"
      "workspace name:discord, class:vesktop"
      "workspace name:terminal, class:Alacritty"
      "suppressevent maximize, class:.*"
    ];

  };

}
