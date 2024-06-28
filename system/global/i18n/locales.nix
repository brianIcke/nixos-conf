{ config, pkgs, ... }:

{
    # Select internationalisation properties.
    i18n.defaultLocale = "de_DE.UTF-8";
    i18n.supportedLocales = [
        "de_DE.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
    ];
}