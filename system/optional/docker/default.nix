{ config, pkgs, ... }:

{
    # Enable docker
    virtualisation.docker.enable = true;

    # Rootless docker
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
}