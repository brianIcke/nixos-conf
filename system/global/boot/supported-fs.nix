{ config, pkgs, ... }:

{
    # NTFS support
    boot.supportedFilesystems = [ "ntfs" ];
}