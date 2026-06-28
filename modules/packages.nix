{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    ## CLI tools
    eza
    bat
    ripgrep
    fd
    dust
    bandwhich
    tldr
    htop
    btop
    neofetch
    fzf
    jq
    yq
    delta
    tmate

    ## File management
    unzip
    zip
    p7zip
    rsync

    ## Media
    mpv
    vlc
    celluloid
    ffmpeg
    imagemagick

    ## Network
    curl
    wget
    nmap
    iperf3
    wireguard-tools

    ## Wayland / clipboard
    wl-clipboard
    wlr-randr
    grim
    slurp
    wlogout
    xorg.setxkbmap
    libsForQt5.qt5.qtwayland
    qt6.qtwayland

    ## Shell
    oh-my-posh
    zellij
    yazi

    ## Terminals
    tilda
    xfce.xfce4-terminal

    ## Development
    opencode
    lazygit
    ansible

    ## Misc
    obsidian
    libnotify
    playerctl
    pavucontrol
    pulseaudio
    brightnessctl

    ## System
    dbus
    gnumake
    gnused
    gawk
    which
  ];

  ## ── GTK shell integration (GTK runs via Wayland) ───────────────────
  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
  };
}
