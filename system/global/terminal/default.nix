{ pkgs, ... }:
{
  # Enable ZSH system-wide
  programs.zsh.enable = true;

  # Enable tmux system-wide
  programs.tmux = {
    enable = true;
    extraConfig = "set -g mouse";
  };

  # Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    nmap
    bat
    fastfetch
    fzf
    zoxide
    gh
    htop
    xclip
    usbutils
  ];
}
