{
  # VirtualBox support
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "brian" ];

  # VirtualBox extensions
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
