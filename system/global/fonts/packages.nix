{ config, pkgs, ... }:

{
    # Fonts
    fonts.packages = with pkgs; [
    font-awesome
    ubuntu_font_family
    carlito
    vistafonts
    corefonts
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
}