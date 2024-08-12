{
  # Enable avahi daemon (eg. autodiscovery of network-printers)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
