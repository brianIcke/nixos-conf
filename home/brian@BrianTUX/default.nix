{ config, pkgs, unstable, nixvim-hm, ... }:

{
  imports =
    [
      # Global modules
      ../global

      # Optional modules
      nixvim-hm
      ../optional/hypr/configs/gaming

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
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    hfsprogs
    vesktop
    unstable.AusweisApp2
    libgpod
    strawberry
    calibre
    bruno
    blender
    android-studio
    arduino-ide
    jetbrains.idea-community
    godot_4
    dolphin-emu
    prismlauncher
    lutris
    libsForQt5.ktouch

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
      source = ../optional/hypr/configs/gaming/dotfiles/catppuccin;
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

  # ZSH
  programs.zsh = {
    enable = true;
    initExtra = "fastfetch\neval \"$(zoxide init zsh)\"";
    shellAliases = {
      cat = "bat";
      top = "htop";
      cd = "z";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
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

  # Enable tmux
  programs.tmux = {
    enable = true;
    extraConfig = "set -g mouse";
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
    userEmail = "mail@brian-nickel.de";
  };

}
