{ config, pkgs, ... }:

{
    # VSCodium
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
      
      userSettings = {
        "platformio-ide.useBuiltinPIOCore" = "false";
        "workbench.colorTheme" = "Dracula Soft";
        "workbench.iconTheme" = "material-icon-theme";
      };

      extensions = with pkgs.vscode-extensions; [
        astro-build.astro-vscode
        redhat.ansible
        ms-python.python
        golang.go
        ms-vscode.cpptools
        rust-lang.rust-analyzer
        jnoortheen.nix-ide
        dracula-theme.theme-dracula
        vscodevim.vim
        yzhang.markdown-all-in-one
        vadimcn.vscode-lldb
        tamasfe.even-better-toml
        serayuzgur.crates
        redhat.vscode-yaml
        adpyke.codesnap
        esbenp.prettier-vscode
        bradlc.vscode-tailwindcss
        pkief.material-icon-theme
        mikestead.dotenv
        seatonjiang.gitmoji-vscode
      ];
    };
}