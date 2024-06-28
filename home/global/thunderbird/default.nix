{ config, pkgs, ... }:

{
  # Enable Thunderbird
  programs.thunderbird = {
    enable = true;
  };

  # Thunderbird profile
  programs.thunderbird.profiles.brian-nickel.isDefault = true;
}