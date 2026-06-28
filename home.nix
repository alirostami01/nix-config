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

    ## ── Wayland environment ──────────────────────────────────────────
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  programs.home-manager.enable = true;
}
