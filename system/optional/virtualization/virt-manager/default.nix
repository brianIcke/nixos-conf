{
  # Libvirtd 
  virtualisation.libvirtd.enable = true;

  # Virt-manager
  programs.virt-manager.enable = true;
  users.extraGroups.libvirtd.members = [ "brian" ]; # Add brian to libvirtd group
}
