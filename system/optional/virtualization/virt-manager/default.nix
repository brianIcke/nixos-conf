{ pkgs, ... }:
{
  # Libvirtd 
  virtualisation.libvirtd.enable = true;

  # Virt-manager
  programs.virt-manager.enable = true;
  users.extraGroups.libvirtd.members = [ "brian" ]; # Add brian to libvirtd group

  # Allow libvirtd to create an emulated TPM using swtpm
  virtualisation.libvirtd.qemu.swtpm.enable = true;

  # Enable all ovmf uefi packages
  virtualisation.libvirtd.qemu.ovmf.packages = [ pkgs.OVMFFull.fd ];

  # Spice USB Redirect
  virtualisation.spiceUSBRedirection.enable = true;
}
