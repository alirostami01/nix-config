# Wayland Migration Guide — X11/i3 → Wayland/Sway

This document details every change made during the migration from **X11 + i3** to
**Wayland + Sway**. It serves as a reference for understanding what was swapped,
why, and how the new environment works.

---

## Package Swap Table (X11 → Wayland)

| X11 Package | Removed? | Wayland Replacement | Notes |
|-------------|----------|-------------------|-------|
| `i3` | Yes | `sway` | 1-to-1 drop-in via `wayland.windowManager.sway` |
| `i3status` | Yes | `waybar` | Declarative config with Nord theme in `window-manager.nix` |
| `picom` | Yes | *(removed)* | Sway is a fully-featured compositor — no external compositor needed |
| `rofi` | Yes | `wofi` | Native Wayland launcher; all rofi themes/applets removed |
| `i3lock` | Yes | `swaylock` | Native Wayland screen locker |
| `xss-lock` | Yes | `swayidle` | Native Wayland idle/suspend manager |
| `feh` | Yes | `swaybg` | Native Wayland wallpaper daemon |
| `betterlockscreen` | Yes | `swaylock` | Replaced by direct swaylock config |
| `nitrogen` | Yes | `swaybg` | Wallpaper handled declaratively in Sway config |
| `xclip` | Yes | `wl-clipboard` | Wayland-native clipboard (`wl-copy` / `wl-paste`) |
| `xdotool` | Yes | *(removed)* | No direct replacement; automation uses `swaymsg` + `ydotool` if needed |
| `xorg.xrandr` | Yes | `wlr-randr` | Wayland-native display query tool |
| `xorg.xsetroot` | Yes | *(removed)* | Not needed — Sway manages root window |
| `maim` | Yes | `grim` | Wayland-native screenshot tool |
| `slop` | Yes | `slurp` | Wayland-native region selection |
| `dunst` | Yes | `mako` | Wayland-native notification daemon (Nord themed) |
| `xfce4-panel` | Yes | *(removed)* | Sway has its own workspace management — no panel needed |
| `xfce4-whiskermenu-plugin` | Yes | *(removed)* | wofi provides application launching |
| `setxkbmap` | Kept | *(same)* | Still used for XWayland compatibility, but Sway-native xkb config is primary |

### Kept (work on both X11 and Wayland)

| Package | Notes |
|---------|-------|
| `kitty` | Has native Wayland backend — runs on Wayland without XWayland |
| `zellij` | Terminal multiplexer — Wayland-agnostic |
| `yazi` | Terminal file manager — Wayland-agnostic |
| `tilda` | Dropdown terminal — works via XWayland |
| `xfce4-terminal` | Works via XWayland |
| `thunar` | File manager — works via XWayland |
| `obsidian`, `vlc`, `mpv`, etc. | Most GUI apps work fine with Wayland |

---

## Structural Changes

### 1. `modules/window-manager.nix` — Complete rewrite

**Before (X11/i3):** 275 lines using `xsession.windowManager.i3` with:
- `programs.i3status` (11 modules, Nord colors)
- `services.picom` (GLX backend, opacity rules)
- `programs.rofi` (adi1090x themes, launchers, applets, powermenus)
- `home.file.".xsession"` (starts i3)
- Two inline shell scripts: `toggle_lang`, `toggle_panel`
- `xdg.configFile."rofi/..."` for the full rofi theme collection

**After (Wayland/Sway):** 310 lines using `wayland.windowManager.sway` with:
- **Sway** replaces i3 with equivalent config:
  - Same `Mod4` modifier, same workspace names (number-based)
  - Same Nord color palette (`#2E3440`, `#81a1c1`, etc.)
  - Same gap sizes (inner 15, outer 5)
  - Same keybindings translated to Sway syntax
  - `mode "resize"` preserved identically
- **Waybar** replaces i3status with:
  - Sway workspace indicator, window title, keyboard layout, audio, network, CPU, memory, clock, system tray
  - Full Nord-themed CSS styling
- **Sway native xkb config** replaces `toggle_lang` script:
  - `input type:keyboard { xkb_layout us,ir; xkb_options grp:win_space_toggle; }`
- **Swayidle** replaces `xss-lock`:
  - 5min → lock, 10min → DPMS off, resume → DPMS on, before-sleep → lock
- **Wofi** replaces rofi:
  - `$mod+d` → `wofi --show drun` (application launcher)
  - `$mod+x` → `wofi --show power` (power menu)
  - Custom sway-power script for full power menu (lock/logout/reboot/shutdown/sleep)
- **Grim + slurp** replaces maim + slop:
  - `Print` → area screenshot to clipboard
  - `Shift+Print` → full screen to clipboard
- **Swaybg** replaces feh: wallpaper via `exec_always`
- **Swaylock** replaces i3lock + betterlockscreen
- **Mako** notification daemon replaces dunst (Nord themed)
- Three new helper scripts in `~/.local/bin/`:
  - `sway-screenshot` (area/screen/window)
  - `sway-power` (wofi power menu)
  - `sway-toggle-lang` (keyboard layout cycling)

### 2. `modules/desktop.nix` — Package swaps

**Removed:** `feh`, `i3lock`, `xss-lock`, `betterlockscreen`, `nitrogen`, `picom`, `xfce4-panel`, `xfce4-whiskermenu-plugin`  
**Added:** `swaybg`, `swaylock`, `swayidle`, `wofi`, `waybar`, `mako`, `wl-clipboard`, `wlr-randr`, `grim`, `slurp`, `wlogout`

Removed config blocks: `betterlockscreen/betterlockscreenrc`, `nitrogen/nitrogen.cfg`

### 3. `modules/packages.nix` — X11→Wayland tool swap

**Removed:** `xclip`, `xdotool`, `xorg.xrandr`, `xorg.xsetroot`, `maim`, `slop`, `nitrogen`, `dunst`, `betterlockscreen`, `xfce4-panel`, `xfce4-whiskermenu-plugin`, `picom`  
**Added:** `wl-clipboard`, `wlr-randr`, `grim`, `slurp`, `wlogout`, `libsForQt5.qt5.qtwayland`, `qt6.qtwayland`

### 4. `home.nix` — Wayland environment variables

Added comprehensive Wayland session variables:
```
XDG_SESSION_TYPE = "wayland"
XDG_CURRENT_DESKTOP = "sway"
NIXOS_OZONE_WL = "1"           # Electron apps
MOZ_ENABLE_WAYLAND = "1"       # Firefox
QT_QPA_PLATFORM = "wayland;xcb"
SDL_VIDEODRIVER = "wayland"
_JAVA_AWT_WM_NONREPARENTING = "1"
CLUTTER_BACKEND = "wayland"
GDK_BACKEND = "wayland"
XCURSOR_THEME = "Adwaita"
XCURSOR_SIZE = "24"
```

### 5. Removed files

- **Entire `config/rofi/` directory** (~200 files: launchers, applets, powermenus, colors, scripts, images) — no longer needed with wofi
- **`home.file.".xsession"`** — replaced by Sway's native session management

---

## Preserved Intact (Ecosystem)

The following modules were **not modified** during migration:

| Module | File | Reason |
|--------|------|--------|
| **Shell** | `modules/shell.nix` | Zsh, oh-my-zsh, oh-my-posh, fzf, bash — all shell agnostic |
| **Terminal** | `modules/terminal.nix` | Kitty (Wayland-native), Zellij, Yazi, Tilda, btop, htop — all work on Wayland |
| **Editor** | `modules/editors.nix` | Neovim with NvChad — terminal-based, no display server dependency |
| **Development** | `modules/development.nix` | LSPs, Rust, Go, Node — toolchain only |
| **Git** | `modules/git.nix` | Git config — no changes needed |

Key ecosystem behaviors that remain functional:
- **Kitty** auto-starts Zellij (via zsh `initExtra`) — unchanged
- **Zellij** uses the same `config.kdl` and `layouts/` — unchanged
- **Yazi** opens files with nvim — unchanged
- **Neovim** NvChad setup with 66 plugins — unchanged
- **Oh-my-posh** prompt with Cobalt2 theme — unchanged

---

## Testing the Migration

### 1. Deploy on a machine with Sway

```bash
cd ~/my-work/nix-config
home-manager switch --flake .#ali
```

### 2. Verify everything

```bash
# Confirm Sway is the WM
swaymsg -t get_version

# Check Wayland session
echo $XDG_SESSION_TYPE   # should print "wayland"

# Test screenshot
grim - | wl-copy

# Test launcher
wofi --show drun

# Test lock
swaylock -f
```

### 3. If something breaks

Switch back to the `master` branch:

```bash
cd ~/my-work/nix-config
git checkout master
home-manager switch --flake .#ali
```

### 4. Common issues

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| Sway won't start | Missing session file | Log in to a TTY and run `sway` directly |
| Electron apps blank | Missing OZONE variable | `export NIXOS_OZONE_WL=1` (already in `home.nix`) |
| Firefox won't use Wayland | Missing MOZ variable | `export MOZ_ENABLE_WAYLAND=1` (already in `home.nix`) |
| Keyboard layout wrong | Sway input config | Run `swaymsg input type:keyboard xkb_layout us,ir` |
| Screenshot not working | Missing grim/slurp | Verify they're installed: `which grim && which slurp` |
| Clipboard not working | Missing wl-clipboard | Verify: `which wl-copy` |

### 5. Optional: Make Sway the default session

If using a display manager (SDDM, GDM, etc.), Sway should appear automatically.
If logging in from a TTY, add to `.bash_profile` or `.zprofile`:

```bash
if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec sway
fi
```

---

## Git History

This migration lives on the `wayland` branch:

```
wayland  ← current (Sway/Wayland)
master   ← original (i3/X11) — preserved for fallback
```

To view the full diff of the X11→Wayland transition:

```bash
git diff master..wayland
```
