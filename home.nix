{ config, pkgs, ... }: {

  home.username = "ali";
  home.homeDirectory = "/home/ali";
  home.stateVersion = "24.11";

  imports = [
    ./modules/window-manager.nix
    ./modules/shell.nix
    ./modules/terminal.nix
    ./modules/editors.nix
    ./modules/development.nix
    ./modules/git.nix
    ./modules/desktop.nix
    ./modules/packages.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
