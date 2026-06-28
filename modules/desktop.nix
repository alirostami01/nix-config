{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    ## Fonts (Nerd Fonts & UI)
    (nerdfonts.override { fonts = [ "FiraMono" "JetBrainsMono" "DejaVuSansMono" ]; })
    font-awesome
    noto-fonts
    noto-fonts-emoji

    ## GTK theme components
    adwaita-icon-theme
    papirus-icon-theme

    ## Desktop utilities
    feh
    i3lock
    xss-lock
    betterlockscreen
    networkmanagerapplet
    dex
    nitrogen
    xfce.xfce4-panel
    xfce.thunar
    xfce.xfce4-terminal
    xfce.xfce4-whiskermenu-plugin
    picom
  ];

  gtk = {
    enable = true;
    font = {
      name = "DejaVu Sans";
      size = 10;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.adw-gtk3;
    };
    gtk2.configLocation = "${config.home.homeDirectory}/.gtkrc-2.0";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk3.bookmarks = [
      "file://${config.home.homeDirectory}/Documents"
      "file://${config.home.homeDirectory}/Music"
      "file://${config.home.homeDirectory}/Pictures"
      "file://${config.home.homeDirectory}/Videos"
      "file://${config.home.homeDirectory}/Downloads"
    ];
  };

  services.network-manager-applet.enable = true;

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };

  ## ── betterlockscreen ──────────────────────────────────────────────
  xdg.configFile."betterlockscreen/betterlockscreenrc".text = ''
    font="sans-serif"
    ringcolor=ffffffff
    insidecolor=00000000
    keyhlcolor=d8dee9ff
    bshlcolor=d8dee9ff
    separatorcolor=00000000
    insidevercolor=00000000
    insidewrongcolor=00000000
    ringvercolor=88c0d0ff
    ringwrongcolor=bf616aff
    loginbox=00000066
  '';

  ## ── nitrogen (Wallpaper Manager) ──────────────────────────────────
  xdg.configFile."nitrogen/nitrogen.cfg".text = ''
    [geometry]
    posx=960
    posy=18
    sizex=956
    sizey=1041

    [nitrogen]
    view=icon
    recurse=true
    sort=alpha
    icon_caps=false
    dirs=
  '';

  ## ── XFCE4 Terminal ────────────────────────────────────────────────
  xdg.configFile."xfce4/terminal/terminalrc".text = ''
    [Configuration]
    BackgroundMode=TERMINAL_BACKGROUND_TRANSPARENT
    MiscAlwaysShowTabs=FALSE
    MiscBell=FALSE
    MiscBellUrgent=FALSE
    MiscBordersDefault=TRUE
    MiscCursorBlinks=FALSE
    MiscCursorShape=TERMINAL_CURSOR_SHAPE_BLOCK
    MiscDefaultGeometry=80x24
    MiscInheritGeometry=FALSE
    MiscMenubarDefault=TRUE
    MiscMouseAutohide=FALSE
    MiscMouseWheelZoom=TRUE
    MiscToolbarDefault=FALSE
    MiscConfirmClose=TRUE
    MiscCycleTabs=TRUE
    MiscTabCloseButtons=TRUE
    MiscTabCloseMiddleClick=TRUE
    MiscTabPosition=GTK_POS_TOP
    MiscHighlightUrls=TRUE
    MiscMiddleClickOpensUri=FALSE
    MiscCopyOnSelect=FALSE
    MiscShowRelaunchDialog=TRUE
    MiscRewrapOnResize=TRUE
    MiscUseShiftArrowsToScroll=FALSE
    MiscSlimTabs=FALSE
    MiscNewTabAdjacent=FALSE
    MiscSearchDialogOpacity=100
    MiscShowUnsafePasteDialog=TRUE
    MiscRightClickAction=TERMINAL_RIGHT_CLICK_ACTION_CONTEXT_MENU
  '';

  ## ── Default Applications (MIME) ────────────────────────────────────
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/x-shellscript" = [ "code.desktop" ];
      "video/mp4" = [ "mpv.desktop" "io.github.celluloid_player.Celluloid.desktop" "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
      "audio/mpeg" = [ "vlc.desktop" ];
      "text/html" = [ "google-chrome.desktop" "code.desktop" ];
      "application/javascript" = [ "code.desktop" ];
      "application/json" = [ "code.desktop" "xed.desktop" ];
      "text/plain" = [ "code.desktop" ];
      "audio/x-wav" = [ "vlc.desktop" ];
      "video/mpeg" = [ "vlc.desktop" ];
      "image/png" = [ "pix.desktop" ];
      "text/css" = [ "code.desktop" ];
    };
    defaultApplications = {
      "video/mp4" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
    };
  };

  ## ── XDG User Directories ───────────────────────────────────────────
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "$HOME/Desktop";
    download = "$HOME/Downloads";
    templates = "$HOME/Templates";
    publicShare = "$HOME/Public";
    documents = "$HOME/Documents";
    music = "$HOME/Music";
    pictures = "$HOME/Pictures";
    videos = "$HOME/Videos";
  };
}
