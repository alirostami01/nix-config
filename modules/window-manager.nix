{ config, pkgs, lib, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      fonts = {
        names = [ "pango:DejaVu Sans Mono" "FontAwesome" ];
        size = 12.0;
      };
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      keybindings = {
        ## ── Applications ──────────────────────────────────────────────
        "${modifier}+Return" = "exec kitty";
        "${modifier}+d" = "exec wofi --show drun";
        "${modifier}+Shift+q" = "kill";

        ## ── Screenshot ────────────────────────────────────────────────
        "Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
        "Shift+Print" = "exec grim - | wl-copy";

        ## ── Lock & Power ──────────────────────────────────────────────
        "${modifier}+Shift+l" = "exec swaylock -f -i /home/ali/Pictures/wallpaper/1.png";
        "${modifier}+x" = "exec wofi --show power";

        ## ── Layout ────────────────────────────────────────────────────
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+Shift+v" = "split vertical";
        "${modifier}+Shift+h" = "split horizontal";

        ## ─S─ Navigation ───────────────────────────────────────────────
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        ## ── Move windows ──────────────────────────────────────────────
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        ## ── Workspaces ────────────────────────────────────────────────
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";

        ## ── Layouts ───────────────────────────────────────────────────
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";

        ## ── Resize mode ───────────────────────────────────────────────
        "${modifier}+r" = "mode resize";

        ## ── Reload ────────────────────────────────────────────────────
        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+e" = "exit";

        ## ── Audio ─────────────────────────────────────────────────────
        "XF86AudioRaiseVolume" = "exec amixer -D pulse sset Master 5%+";
        "XF86AudioLowerVolume" = "exec amixer -D pulse sset Master 5%-";
        "XF86AudioMute" = "exec amixer -D pulse sset Master toggle";
        "XF86AudioMicMute" = "exec amixer -D pulse sset Capture toggle";

        ## ── Brightness ────────────────────────────────────────────────
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
      };
      assigns = {
        "1" = [{ app_id = "^firefox$"; } { class = "^firefox$"; }];
        "2" = [{ app_id = "^kitty$"; }];
      };
      gaps = {
        inner = 15;
        outer = 5;
        smartGaps = false;
        smartBorders = "off";
      };
      colors = {
        focused = { border = "#81a1c1"; background = "#81a1c1"; text = "#ffffff"; indicator = "#81a1c1"; childBorder = "#81a1c1"; };
        unfocused = { border = "#2e3440"; background = "#1f222d"; text = "#888888"; indicator = "#2e3440"; childBorder = "#1f222d"; };
        focusedInactive = { border = "#2e3440"; background = "#1f222d"; text = "#888888"; indicator = "#2e3440"; childBorder = "#1f222d"; };
        urgent = { border = "#900000"; background = "#900000"; text = "#ffffff"; indicator = "#900000"; childBorder = "#900000"; };
        placeholder = { border = "#2e3440"; background = "#1f222d"; text = "#888888"; indicator = "#2e3440"; childBorder = "#1f222d"; };
        background = "#242424";
      };
      window = {
        commands = [
          { command = "border pixel 2"; criteria = { }; }
        ];
      };
      startup = [
        { command = "dex --autostart --environment sway"; always = false; }
        { command = "nm-applet --indicator"; always = false; }
        { command = "swaybg -i /home/ali/Pictures/wallpaper/windmill_clouds.png -m fill"; always = true; }
        { command = "swayidle -w timeout 300 'swaylock -f -i /home/ali/Pictures/wallpaper/1.png' timeout 600 'swaymsg \"output * dpms off\"' resume 'swaymsg \"output * dpms on\"' before-sleep 'swaylock -f -i /home/ali/Pictures/wallpaper/1.png'"; always = true; }
        { command = "setxkbmap -layout us,ir -option grp:win_space_toggle"; always = true; }
        { command = "mako"; always = false; }
      ];
    };
    extraConfig = ''
      default_border pixel 2

      ## ── Input configuration ──────────────────────────────────────────
      input type:keyboard {
          xkb_layout us,ir
          xkb_options grp:win_space_toggle
      }

      ## ── Gaps for individual windows ──────────────────────────────────
      for_window [app_id=".*"] border pixel 2

      ## ── Resize mode ──────────────────────────────────────────────────
      mode "resize" {
          bindsym h resize shrink width 10 px
          bindsym j resize grow height 10 px
          bindsym k resize shrink height 10 px
          bindsym l resize grow width 10 px
          bindsym Left resize shrink width 10 px
          bindsym Down resize grow height 10 px
          bindsym Up resize shrink height 10 px
          bindsym Right resize grow width 10 px
          bindsym Return mode "default"
          bindsym Escape mode "default"
          bindsym $mod+r mode "default"
      }

      ## ── Floating window settings ────────────────────────────────────
      floating_minimum_size 200x200

      ## ── Smart gaps ───────────────────────────────────────────────────
      smart_gaps off
      smart_borders off
    '';
  };

  ## ── Waybar (Status Bar) ─────────────────────────────────────────────
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 30;
        spacing = 8;
        modules-left = [ "sway/workspaces" "sway/mode" "sway/scratchpad" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "custom/kblayout" "pulseaudio" "network" "cpu" "memory" "clock" "tray" ];
        "sway/workspaces" = {
          all-outputs = true;
        };
        "sway/window" = {
          max-length = 80;
        };
        "custom/kblayout" = {
          exec = "swaymsg -t get_inputs | jq -r '.[] | select(.type == \"keyboard\") | .xkb_active_layout_name' | head -1";
          interval = 1;
          format = "⌨ {}";
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-icons = { default = [ "🔇" "🔈" "🔉" "🔊" ]; };
          on-click = "pavucontrol";
        };
        "network" = {
          format = "{ifname}";
          format-wifi = " {essid}  {signalStrength}%";
          format-ethernet = " {ipaddr}";
          format-disconnected = "❌ Disconnected";
          tooltip = false;
        };
        "cpu" = {
          format = " {usage}%";
        };
        "memory" = {
          format = "RAM:{percentage}%";
        };
        "clock" = {
          format = "{:%Y-%m-%d  %H:%M:%S}";
          tooltip = false;
        };
        "tray" = {
          spacing = 8;
        };
      };
    };
    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: "DejaVu Sans Mono", "FontAwesome";
          font-size: 13px;
          min-height: 0;
      }

      window#waybar {
          background: #2E3440;
          color: #D8DEE9;
      }

      #workspaces button {
          padding: 0 5px;
          background: #3B4252;
          color: #D8DEE9;
      }

      #workspaces button.focused {
          background: #5E81AC;
          color: #E5E9F0;
      }

      #workspaces button.urgent {
          background: #BF616A;
          color: #ECEFF4;
      }

      #clock, #cpu, #memory, #network, #pulseaudio, #custom-kblayout, #tray {
          padding: 0 8px;
          color: #D8DEE9;
      }

      #clock { color: #E5E9F0; }
      #cpu { color: #A3BE8C; }
      #memory { color: #EBCB8B; }
      #network { color: #88C0D0; }
      #pulseaudio { color: #B48EAD; }
      #custom-kblayout { color: #81A1C1; }
    '';
  };

  ## ── Notification Daemon ─────────────────────────────────────────────
  services.mako = {
    enable = true;
    backgroundColor = "#2E3440";
    textColor = "#D8DEE9";
    borderColor = "#81a1c1";
    borderRadius = 5;
    borderSize = 2;
    defaultTimeout = 5000;
    font = "DejaVu Sans 10";
    anchor = "top-right";
    width = 350;
    height = 150;
    margin = "10";
    padding = "10";
    extraConfig = ''
      [urgency=low]
      background=#3B4252

      [urgency=normal]
      background=#434C5E

      [urgency=high]
      background=#BF616A
      border-color=#BF616A
      default-timeout=0
    '';
  };

  ## ── Screenshot Script ──────────────────────────────────────────────
  home.file.".local/bin/sway-screenshot" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -e
      case "''${1:-}" in
          area)
              grim -g "$(slurp)" - | wl-copy
              notify-send "Screenshot" "Area captured to clipboard"
              ;;
          screen)
              grim - | wl-copy
              notify-send "Screenshot" "Screen captured to clipboard"
              ;;
          window)
              grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" - | wl-copy
              notify-send "Screenshot" "Window captured to clipboard"
              ;;
          *)
              echo "Usage: $0 {area|screen|window}"
              exit 1
              ;;
      esac
    '';
  };

  ## ── Power Menu Script (for wofi) ───────────────────────────────────
  home.file.".local/bin/sway-power" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      entries="Lock\nLogout\nReboot\nShutdown\nSleep"
      selected=$(echo -e "$entries" | wofi --dmenu --prompt "Power Menu" --width 200 --height 200)
      case $selected in
          Lock) swaylock -f -i /home/ali/Pictures/wallpaper/1.png ;;
          Logout) swaymsg exit ;;
          Reboot) systemctl reboot ;;
          Shutdown) systemctl poweroff ;;
          Sleep) systemctl suspend ;;
      esac
    '';
  };

  ## ── Keyboard Layout Toggle Script (for waybar exec) ────────────────
  home.file.".local/bin/sway-toggle-lang" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      swaymsg input type:keyboard xkb_switch_layout next
    '';
  };

  ## ── GTK key theme (Wayland-native clipboard) ───────────────────────
  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };
}
