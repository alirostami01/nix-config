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

    ## X11 / clipboard
    xclip
    xdotool
    xorg.setxkbmap
    xorg.xrandr
    xorg.xsetroot
    maim
    slop
    nitrogen

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
    dunst
    playerctl
    pavucontrol
    pulseaudio
    brightnessctl
    betterlockscreen

    ## System
    dbus
    gnumake
    gnused
    gawk
    which
  ];
}
