{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    ## Neovim plugins & LSPs (pre-installed for Mason-free setup)
    rust-analyzer
    lua-language-server
    nil
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    stylua
    codelldb

    ## Rust ecosystem
    rustup
    cargo
    rustc

    ## Go
    go
    gopls

    ## Node / JS
    nodejs_22
    nodePackages.npm

    ## Python
    python3
    python3Packages.pip

    ## Build tools
    gcc
    cmake
    pkg-config
    openssl
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      gui.theme = {
        lightTheme = false;
        activeBorderColor = [ "#81a1c1" "bold" ];
        inactiveBorderColor = [ "#4C566A" ];
      };
    };
  };
}
