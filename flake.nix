{
  description = "My Nix system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # HomeManager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixvim for configure Neovim
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };


  outputs = { nixpkgs, nixpkgs-unstable, home-manager, nixvim, lanzaboote, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        # Allow non-free packages
        config = { allowUnfree = true; };
      };

      unstable = import nixpkgs-unstable {
        inherit system;

        # Allow non-free packages
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;

      # Home Manager module
      nixos-hm = home-manager.nixosModules.home-manager;

      # Nixvim NixOS module
      nixvim-nixos = nixvim.nixosModules.nixvim;

      # Nixvim HomeManager module
      nixvim-hm = nixvim.homeManagerModules.nixvim;

    in
    {

      "brian@tuxbook" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          # Home Manager configuration
          (./. + "/home/brian@tuxbook/home.nix")

          # Other modules
          nixvim-hm
        ];

        extraSpecialArgs = { inherit unstable; };

      };

      nixosConfigurations = {

        "BrianTUX" = lib.nixosSystem {
          inherit pkgs system;

          modules = [
            # System configuration
            ./system/BrianTUX

            # Home Manager Module
            nixos-hm
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.brian = import (./. + "/home/brian@BrianTUX");
              home-manager.extraSpecialArgs = { inherit nixvim-hm unstable; };
            }

            # Other modules
          ];
        };

        "tuxbook" = lib.nixosSystem {
          inherit pkgs system;

          modules = [
            # System configuration
            ./system/tuxbook/configuration.nix

            # Other modules
            nixvim-nixos
          ];
        };

        "workstation" = lib.nixosSystem {
          inherit pkgs system;

          modules = [
            # System configuration
            ./system/workstation

            # Home Manager Module
            nixos-hm
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.brian = import (./. + "/home/brian@workstation");
              home-manager.extraSpecialArgs = { inherit nixvim-hm unstable; };
            }


            lanzaboote.nixosModules.lanzaboote

            ({ pkgs, lib, ... }: {

              environment.systemPackages = [
                # For debugging and troubleshooting Secure Boot.
                pkgs.sbctl
              ];

              # Lanzaboote currently replaces the systemd-boot module.
              # This setting is usually set to true in configuration.nix
              # generated at installation time. So we force it to false
              # for now.
              #boot.loader.systemd-boot.enable = lib.mkForce false;

              #boot.lanzaboote = {
              #  enable = true;
              #  pkiBundle = "/etc/secureboot";
              #};
            })

          ];
        };
      };
    };

}
