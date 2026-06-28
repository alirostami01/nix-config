{ config, pkgs, ... }: let
  toggle_lang = pkgs.writeShellScript "toggle_lang" ''
    CURRENT_LAYOUT=$(setxkbmap -query | grep layout | awk '{print $2}')
    if [ "$CURRENT_LAYOUT" = "us" ]; then
        setxkbmap ir
        echo "FA" > /tmp/kb_layout
    else
        setxkbmap us
        echo "EN" > /tmp/kb_layout
    fi
    pkill -USR1 i3status
  '';
  toggle_panel = pkgs.writeShellScript "toggle_panel" ''
    if pgrep -x "xfce4-panel" > /dev/null; then
        killall xfce4-panel
    else
        xfce4-panel --disable-wm-check &
    fi
  '';
in {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod4";
        fonts = {
          names = [ "monospace" "pango:DejaVu Sans Mono" "FontAwesome" ];
          size = 8.0;
        };
        bars = [{
          statusCommand = "i3status";
          position = "bottom";
          trayOutput = "primary";
          extraConfig = "i3bar_command i3bar --transparency";
          fonts = {
            names = [ "DejaVu Sans Mono" "FontAwesome" ];
            size = 12.0;
          };
          colors = {
            background = "#2E3440";
            statusline = "#D8DEE9";
            separator = "#4C566A";
            focusedWorkspace = { border = "#5E81AC"; background = "#2E3440"; text = "#E5E9F0"; };
            activeWorkspace = { border = "#4C566A"; background = "#2E3440"; text = "#D8DEE9"; };
            inactiveWorkspace = { border = "#3B4252"; background = "#2E3440"; text = "#D8DEE9"; };
            urgentWorkspace = { border = "#BF616A"; background = "#2E3440"; text = "#ECEFF4"; };
          };
        }];
        keybindings = {
          "${config.xsession.windowManager.i3.config.modifier}+Return" = "exec kitty";
          "${config.xsession.windowManager.i3.config.modifier}+Shift+q" = "kill";
          "${config.xsession.windowManager.i3.config.modifier}+d" = "exec ~/.config/rofi/launchers/type-2/launcher.sh";
          "${config.xsession.windowManager.i3.config.modifier}+Shift+l" = "exec i3lock -i /home/ali/Pictures/wallpaper/1.png";
          "${config.xsession.windowManager.i3.config.modifier}+Shift+v" = "split vertical, exec kitty";
          "${config.xsession.windowManager.i3.config.modifier}+Shift+h" = "split horizontal, exec kitty";
          "${config.xsession.windowManager.i3.config.modifier}+space" = "exec ${toggle_lang}";
          "Print" = "exec ~/.config/rofi/applets/bin/screenshot.sh";
          "${config.xsession.windowManager.i3.config.modifier}+x" = "exec ~/.config/rofi/applets/bin/powermenu.sh";
          "XF86AudioRaiseVolume" = "exec amixer -D pulse sset Master 5%+";
          "XF86AudioLowerVolume" = "exec amixer -D pulse sset Master 5%-";
          "XF86AudioMute" = "exec amixer -D pulse sset Master toggle";
          "XF86AudioMicMute" = "exec amixer -D pulse sset Capture toggle";
        };
        assigns = {
          web = [{ workspace = "1"; }];
          dev = [{ workspace = "2"; }];
          apps = [{ workspace = "3"; }];
          temp = [{ workspace = "4"; }];
        };
        workspaceAutoBackAndForth = false;
        gaps = {
          inner = 15;
          outer = 5;
        };
        colors = {
          focused = { border = "#81a1c1"; background = "#81a1c1"; text = "#ffffff"; indicator = "#81a1c1"; childBorder = "#81a1c1"; };
          unfocused = { border = "#2e3440"; background = "#1f222d"; text = "#888888"; indicator = "#2e3440"; childBorder = "#1f222d"; };
          focusedInactive = { border = "#2e3440"; background = "#1f222d"; text = "#888888"; indicator = "#2e3440"; childBorder = "#1f222d"; };
          urgent = { border = "#900000"; background = "#900000"; text = "#ffffff"; indicator = "#900000"; childBorder = "#900000"; };
          placeholder = { border = "#2e3440"; background = "#1f222d"; text = "#888888"; indicator = "#2e3440"; childBorder = "#1f222d"; };
          background = "#242424";
        };
        startup = [
          { command = "dex --autostart --environment i3"; always = false; notification = false; }
          { command = "xss-lock --transfer-sleep-lock -- i3lock --nofork"; always = false; notification = false; }
          { command = "nm-applet"; always = false; notification = false; }
          { command = "feh --bg-fill /home/ali/Pictures/wallpaper/windmill_clouds.png"; always = true; notification = false; }
          { command = "killall picom; picom --config ~/.config/picom/picom.conf -b"; always = true; notification = false; }
          { command = "setxkbmap -layout us,ir"; always = true; notification = false; }
          { command = "bash -c 'setxkbmap -query | grep -q \"layout:\\s*ir\" && echo FA > /tmp/kb_layout || echo EN > /tmp/kb_layout'"; always = true; notification = false; }
          { command = "xsetroot -solid \"#101a30\""; always = true; notification = false; }
        ];
      };
      extraConfig = ''
        default_border pixel 0
        for_window [class=".*"] border pixel 2

        bindsym $mod+1 workspace web
        bindsym $mod+2 workspace dev
        bindsym $mod+3 workspace apps
        bindsym $mod+4 workspace temp
        bindsym $mod+Shift+1 move container to workspace web
        bindsym $mod+Shift+2 move container to workspace dev
        bindsym $mod+Shift+3 move container to workspace apps
        bindsym $mod+Shift+4 move container to workspace temp

        bindsym $mod+h focus left
        bindsym $mod+j focus down
        bindsym $mod+k focus up
        bindsym $mod+l focus right

        bindsym $mod+r mode "resize"
        mode "resize" {
            bindsym l resize shrink width 5 px or 5 ppt
            bindsym j resize grow height 5 px or 5 ppt
            bindsym k resize shrink height 5 px or 5 ppt
            bindsym h resize grow width 5 px or 10 ppt
            bindsym Left resize shrink width 5 px or 5 ppt
            bindsym Down resize grow height 5 px or 5 ppt
            bindsym Up resize shrink height 5 px or 5 ppt
            bindsym Right resize grow width 5 px or 10 ppt
            bindsym Return mode "default"
            bindsym Escape mode "default"
            bindsym $mod+r mode "default"
        }

        bindsym $mod+s layout stacking
        bindsym $mod+w layout tabbed
        bindsym $mod+e layout toggle split
      '';
    };
  };

  programs.i3status = {
    enable = true;
    enableDefault = false;
    general = {
      colors = true;
      interval = 1;
      color_good = "#A3BE8C";
      color_degraded = "#EBCB8B";
      color_bad = "#BF616A";
    };
    modules = {
      "wireless _first_" = {
        position = 1;
        settings = {
          format_up = " %quality at %essid";
          format_down = " down";
        };
      };
      "ethernet _first_" = {
        position = 2;
        settings = {
          format_up = " %ip";
          format_down = " down";
        };
      };
      "cpu_temperature 0" = {
        position = 3;
        settings = {
          format = " %degrees°C";
          max_threshold = 75;
        };
      };
      memory = {
        position = 4;
        settings = {
          format = "RAM:%used";
          threshold_degraded = "75%";
          threshold_critical = "90%";
          format_degraded = "RAM:%used";
        };
      };
      load = {
        position = 5;
        settings = {
          format = " %1min";
        };
      };
      "disk /" = {
        position = 6;
        settings = {
          format = " %free";
        };
      };
      "read_file KBD" = {
        position = 7;
        settings = {
          path = "/tmp/kb_layout";
          format = " ⌨️ %content ";
        };
      };
      "tztime local" = {
        position = 8;
        settings = {
          format = " %Y-%m-%d  %H:%M:%S";
        };
      };
      "volume master" = {
        position = 9;
        settings = {
          format = "♪: %volume";
          format_muted = "♪: Muted (%volume)";
          device = "default";
          mixer = "Master";
          mixer_idx = 0;
        };
      };
    };
    order = [
      "wireless _first_"
      "ethernet _first_"
      "cpu_temperature 0"
      "memory"
      "load"
      "disk /"
      "read_file KBD"
      "tztime local"
      "volume master"
    ];
  };

  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    settings = {
      use-damage = true;
      opacity-rule = [
        "90:class_g = 'Alacritty'"
        "90:class_g = 'xfce4-terminal'"
        "95:class_g = 'URxvt'"
        "90:class_g = 'kitty'"
        "100:class_g = 'Thunar'"
      ];
      inactive-opacity = 0.95;
      active-opacity = 1.0;
    };
  };

  programs.rofi = {
    enable = true;
    extraConfig = ''
      configuration {
        modi: "drun,run,filebrowser,window";
        case-sensitive: false;
        cycle: true;
        show-icons: true;
        icon-theme: "Papirus";
        matching: "normal";
        tokenize: true;
        drun-match-fields: "name,generic,exec,categories,keywords";
        drun-display-format: "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
        drun-show-actions: false;
        terminal: "rofi-sensible-terminal";
        font: "Mono 12";
        click-to-exit: true;
        display-drun: "Apps";
        display-run: "Run";
        display-window: "Windows";
        display-filebrowser: "Files";
      }
    '';
  };

  xdg.configFile."rofi/launchers".source = ../config/rofi/launchers;
  xdg.configFile."rofi/applets".source = ../config/rofi/applets;
  xdg.configFile."rofi/colors".source = ../config/rofi/colors;

  home.file.".xsession".text = ''
    exec i3
  '';
}
