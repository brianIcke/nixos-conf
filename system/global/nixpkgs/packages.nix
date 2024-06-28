{ config, pkgs, ... }:

{
    environment.systemPackages =
    
    let
      # Python packages
      python-packages = ps: with ps; [
        websockets
        pandas
        numpy
        ansible-core
      ];
    in

    with pkgs; [
      vim 
      wget
      curl
      (python312.withPackages python-packages)
      go
      lua
      jdk17
      nmap
      bat
      htop
      nodejs_20
      xclip
      alsa-utils
      pulseaudio
      wineWowPackages.staging
      winetricks
      usbutils
    ];
}