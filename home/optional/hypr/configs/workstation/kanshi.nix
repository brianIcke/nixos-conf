{
  # Enable Kanshi for handling displays when docked

  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 1.1;
            status = "enable";
          }
        ];
      };

      home_office = {
        outputs = [
          {
            criteria = "Dell Inc. DELL P2419H D46Y6X2";
            position = "0,0";
            mode = "1920x1080@60Hz";
          }
          {
            criteria = "Dell Inc. DELL P2419H 237Y6X2";
            position = "3200,0";
            mode = "1920x1080@60Hz";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      };
    };
  };
}
