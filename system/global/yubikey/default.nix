{ config, pkgs, ... }:

{
    # Enable Yubikey support for GPG and SSH
    services.udev.packages = [ pkgs.yubikey-personalization ];
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };
}