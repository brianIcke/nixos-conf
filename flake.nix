{
  description = "My Nix system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";

    # HomeManager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixvim for configure Neovim
    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };


  outputs = { nixpkgs, home-manager, nixvim, ... }: 
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
	# Allow non-free packages
	config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;

      # Nixvim NixOS module
      nixvim-nixos = nixvim.nixosModules.nixvim;

      # Nixvim HomeManager module
      nixvim-hm = nixvim.homeManagerModules.nixvim;

    in {

      homeConfigurations= {
	"brian@BrianTUX" = home-manager.lib.homeManagerConfiguration {
	  inherit pkgs;

          modules = [
	    # HomeManager configuration
            ./home/brian/home.nix

            # Other modules
	    nixvim-hm
  	];

	};

      };

      nixosConfigurations = {
        BrianTUX = lib.nixosSystem {
	  inherit pkgs system;

          modules = [
	   # System configuration
           ./system/configuration.nix 

           # Other modules
	   nixvim-nixos
	  ];
	};
      };
    };
    
}
