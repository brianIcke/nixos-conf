{ config, pkgs, nixvim-hm, unstable, ... }:

{
  imports =
    [
      # Global modules
      ../global

      # Optional modules
      nixvim-hm
      ../optional/hypr/configs/workstation
    ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "brian";
  home.homeDirectory = "/home/brian";

  #nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    unstable.gns3-gui
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    "${config.home.homeDirectory}/.config/waybar" = {
      source = ../optional/waybar/configs/dotfiles/catppuccin;
      recursive = true;
    };

    "${config.home.homeDirectory}/.config/hypr" = {
      source = ../optional/hypr/configs/workstation/dotfiles/catppuccin;
      recursive = true;
    };

    "${config.home.homeDirectory}/.wallpapers" = {
      source = ../optional/wallpapers;
      recursive = true;
    };
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/brian/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # KVM hypervisor connection
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Alacritty
  programs.alacritty.enable = true;
  programs.alacritty.settings = { shell = { program = "${pkgs.tmux}/bin/tmux"; args = [ "new-session" "-A" "-D" "-s" "main" ]; }; };

  # Firefox
  programs.firefox = {
    enable = true;
    policies = {
      ExtensionSettings = {
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          "installation_mode" = "normal_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
        "uBlock0@raymondhill.net" = {
          "installation_mode" = "normal_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        "{4853d046-c5a3-436b-bc36-220fd935ee1d}" = {
          "installation_mode" = "normal_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/undoclosetabbutton/latest.xpi";
        };
        "tab-stash@condordes.net" = {
          "installation_mode" = "normal_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/tab-stash/latest.xpi";
        };
      };
    };
  };

  # ZSH
  programs.zsh = {
    enable = true;
    initExtra = "fastfetch";
    shellAliases = {
      cat = "bat";
      top = "htop";
      avm = "python $HOME/workspace/python/pve_connect/connect_vm.py -vm IVV7BRIANWS -admin&";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];

      theme = "bira";

    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
    ];

  };

  # Neovim config
  programs.nixvim = {
    enable = true;
    colorschemes.tokyonight.enable = true;

    # Use system clipboard
    clipboard.register = "unnamedplus";

    # Plugins
    plugins.airline = {
      enable = true;
    };

    # LSP
    plugins.lsp.enable = true;
    plugins.lsp.servers = {
      bashls = {
        enable = true;
      };
      clangd = {
        enable = true;
      };
      pyright = {
        enable = true;
      };
    };

    opts = {
      number = true;
      relativenumber = true;
      fileencoding = "utf-8";
      hlsearch = true;
      ignorecase = true;
      mouse = "a";
      showtabline = 2;
      smartcase = true;
      smartindent = true;
      undofile = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
    };
  };

  # Git config
  programs.git = {
    enable = true;
    userName = "Brian Nickel";
    userEmail = "brian.nickel@uni-muenster.de";
  };

}
