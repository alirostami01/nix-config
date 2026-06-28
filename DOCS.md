# Home Manager Configuration — Ali Rostami (Wayland/Sway Edition)

This document describes the complete modular Home Manager setup for Ali Rostami's desktop
environment on **Wayland + Sway**. Every application, plugin, package, and configuration
setting is captured declaratively.

---

## Architecture Overview

```
nix-config/
├── flake.nix                          # Nix flake entry point
├── home.nix                           # Top-level config, imports all modules
├── DOCS.md                            # This document
├── WAYLAND_MIGRATION.md               # Migration guide (X11→Wayland diff)
├── modules/
│   ├── window-manager.nix             # sway + waybar + wofi + mako + scripts
│   ├── shell.nix                      # zsh + oh-my-zsh + oh-my-posh + bash + fzf + neofetch
│   ├── terminal.nix                   # kitty + zellij + yazi + tilda + btop + htop
│   ├── editors.nix                    # neovim (NvChad v2.5, 50+ Lua files)
│   ├── development.nix                # LSPs, dev toolchains, lazygit
│   ├── git.nix                        # git + git-lfs user config
│   ├── desktop.nix                    # GTK, fonts, swaybg, swaylock, swayidle, mime, user-dirs
│   └── packages.nix                   # 50+ CLI / media / network / misc packages
├── config/
│   ├── nvim/                          # NvChad Lua config (50 files, 66 plugins)
│   ├── neofetch/                      # Custom neofetch print_info() and settings
│   └── zellij/layouts/               # "clean" (zjstatus) and "default" layouts
└── themes/
    ├── cobalt2.omp.json               # Active oh-my-posh prompt theme
    └── zen.toml                       # Custom minimal oh-my-posh theme
```

### How the modules work together

`home.nix` imports all 8 modules. Each module owns a functional area:

| Module | Owns |
|--------|------|
| `window-manager.nix` | `wayland.windowManager.sway`, `programs.waybar`, `programs.wofi`, `services.mako` |
| `shell.nix` | `programs.zsh`, `programs.bash`, `programs.fzf`, `xdg.configFile` for oh-my-posh & neofetch |
| `terminal.nix` | `programs.kitty`, `programs.zellij`, `programs.yazi`, plus `xdg.configFile` for btop, htop, tilda, keymaps |
| `editors.nix` | `programs.neovim`, `home.file.".config/nvim"` (recursive copy) |
| `development.nix` | LSPs, rust/go/node toolchains, `programs.lazygit` |
| `git.nix` | `programs.git` with user.name, user.email, LFS |
| `desktop.nix` | GTK, fonts, `services.network-manager-applet`, swaybg, swaylock, swayidle, `xdg.mimeApps`, `xdg.userDirs` |
| `packages.nix` | All other CLI and misc packages |

---

## All Installed Packages

### Window Manager & Desktop

| Package | Purpose |
|---------|---------|
| `sway` | Tiling Wayland compositor (via `wayland.windowManager.sway`) |
| `waybar` | Status bar (workspaces, window title, kb layout, audio, network, CPU, memory, clock, tray) |
| `wofi` | Application launcher + power menu |
| `swaybg` | Wallpaper daemon |
| `swaylock` | Screen locker |
| `swayidle` | Idle/suspend manager (5min lock, 10min DPMS) |
| `mako` | Notification daemon (Nord themed) |
| `wlogout` | Logout UI |
| `networkmanagerapplet` | System tray network manager |
| `dex` | Desktop file autostart |
| `grim` + `slurp` | Screenshot + region selection |
| `wl-clipboard` | Wayland clipboard (`wl-copy` / `wl-paste`) |
| `wlr-randr` | Display query tool |
| `thunar` | GUI file manager |
| `xfce4-terminal` | Alternative GTK terminal |

### Terminal & Shell

| Package | Purpose |
|---------|---------|
| `kitty` | Primary GPU-accelerated terminal (Wayland-native) |
| `zellij` | Terminal multiplexer (clean layout, custom keybinds) |
| `yazi` | Terminal file manager (fzf integration) |
| `tilda` | Dropdown terminal (F1 / F2) |
| `zsh` + `oh-my-zsh` | Primary shell with 4 plugins |
| `oh-my-posh` | Prompt theme engine (Cobalt2) |
| `fzf` | Fuzzy finder (Ctrl+T, Ctrl+R) |
| `eza` | Modern `ls` with icons |
| `bat` | `cat` with syntax highlighting |
| `ripgrep` / `fd` | Fast grep / find |
| `dust` | Disk usage analyzer |
| `bandwhich` | Network bandwidth monitor |
| `tldr` | Simplified man pages |
| `btop` | Advanced system monitor (config embedded) |
| `htop` | Classic process viewer (config embedded) |
| `neofetch` | System info display (864-line custom config) |

### Editor & Development Tools

| Package | Purpose |
|---------|---------|
| `neovim` | Primary editor (NvChad v2.5 + 66 lazy.nvim plugins) |
| `lazygit` | Git TUI with Nord theme |
| `rust-analyzer` / `rustup` / `cargo` | Rust toolchain |
| `lua-language-server` | Lua LSP |
| `nil` | Nix LSP |
| `gopls` / `go` | Go toolchain |
| `nodejs_22` / `npm` | JavaScript runtime |
| `python3` / `pip` | Python runtime |
| `typescript-language-server` | TypeScript LSP |
| `vscode-langservers-extracted` | HTML, CSS, JSON LSPs |
| `stylua` | Lua formatter |
| `codelldb` | Rust debugger adapter |
| `gcc` / `cmake` / `pkg-config` | Build toolchain |
| `opencode` | AI coding assistant |

### CLI Utilities

| Package | Purpose |
|---------|---------|
| `jq` / `yq` | JSON / YAML processors |
| `delta` | Git diff viewer |
| `tmate` | Terminal sharing |
| `unzip` / `zip` / `p7zip` | Archive tools |
| `rsync` | File synchronization |
| `wl-clipboard` | Wayland clipboard (replaces xclip) |
| `grim` / `slurp` | Screenshot (replaces maim/slop) |
| `curl` / `wget` | HTTP clients |
| `nmap` / `iperf3` | Network diagnostics |
| `brightnessctl` | Backlight control |
| `playerctl` | Media player control |
| `pavucontrol` / `pulseaudio` | Audio control |
| `libnotify` | Desktop notifications |
| `ansible` | Configuration management |
| `obsidian` | Note-taking |

### Media

| Package | Purpose |
|---------|---------|
| `mpv` | Minimal video player |
| `vlc` | Full-featured media player |
| `celluloid` | MPV frontend |
| `ffmpeg` | Media conversion |
| `imagemagick` | Image manipulation |

### Fonts

| Package | Characters |
|---------|-----------|
| `nerdfonts` (FiraMono, JetBrainsMono, DejaVuSansMono) | 3 Nerd Font variants |
| `font-awesome` | Icon font |
| `noto-fonts` / `noto-fonts-emoji` | Unicode / emoji coverage |

---

## Application Configurations

### Sway Window Manager (`modules/window-manager.nix`)

**Key bindings:**
| Key | Action |
|-----|--------|
| `$mod+Return` | Launch kitty |
| `$mod+d` | Application launcher (wofi) |
| `$mod+x` | Power menu (wofi) |
| `$mod+Space` | Toggle US / Persian keyboard layout (sway input xkb) |
| `$mod+r` | Resize mode |
| `Print` | Area screenshot to clipboard (grim + slurp) |
| `Shift+Print` | Full screen screenshot to clipboard (grim) |
| `$mod+1-4` | Switch workspace |
| `$mod+Shift+1-4` | Move container to workspace |
| `XF86Audio*` | Volume control via pactl |

**Colors:** Nord palette (`#2E3440` background, `#81a1c1` accent).  
**Gaps:** 15px inner, 5px outer.  
**Startup:** swaybg (wallpaper), nm-applet, swayidle, mako, keyboard layout.

### Waybar Status Bar

Modules (left to right): workspaces, window title, keyboard layout, pulseaudio,
network, cpu, memory, clock, system tray. Full Nord-themed CSS styling with
rounded corners and transparent background.

### Mako Notification Daemon

Nord-themed (`#2E3440` background, `#81a1c1` accent border, `#88C0D0` summary,
`#8FBCBB` body). 5s default timeout, 2s for critical, group-by ID.

### Wofi

- `$mod+d` → `wofi --show drun` (application launcher)
- `$mod+x` → custom `sway-power` script (lock / logout / reboot / shutdown / sleep)

### Helper Scripts (deployed to `~/.local/bin/`)

| Script | Purpose |
|--------|---------|
| `sway-screenshot` | Interactive: area, full screen, or focused window (grim + slurp) |
| `sway-power` | Wofi power menu with 5 actions: Lock, Logout, Reboot, Shutdown, Sleep |
| `sway-toggle-lang` | Cycle keyboard layout via `swaymsg input` |

### Kitty Terminal

FiraMono Nerd Font 12pt, no title bar, copy-on-select, no shell title
integration. Native Wayland backend — runs without XWayland.

### Zellij

Custom `config.kdl` with 584 lines of keybindings across 10 modes:
normal, pane, tab, resize, move, scroll, search, session, tmux, locked.
Default layout: "clean" (uses zjstatus plugin for styled tabs).
`pane_frames false`, `show_startup_tips false`.

### Yazi

Default opener: nvim for text/json/empty files. Custom keymap:
- `<C-f>` → find file by filename (fzf)
- `sg` → find file by content (fuzzy)
- `sG` → find file by content (ripgrep)

### Tilda (2 Dropdown Terminals)

- Terminal 0: F1, transparent, pinned at top
- Terminal 1: F2, solid background, pinned at top

### Neovim (NvChad v2.5)

Full NvChad setup with:
- **Theme:** onedark
- **Plugin manager:** lazy.nvim (66 locked plugins including telescope,
  treesitter, mason, lualine, neotree, lspsaga, nvim-cmp, gitsigns,
  nvim-dap, rustaceanvim, auto-tag, conform, etc.)
- **LSPs configured:** html, cssls (via nvim-lspconfig), plus Mason for
  on-demand installation
- **Formatters:** stylua for Lua
- **Custom keymaps:** `;` for command mode, `jk` for escape,
  `<leader>1-9` for buffer switching

### btop

Braille graphs, 2000ms update, CPU lazy sort, temperature monitoring,
clock display, truecolor enabled.

### htop

Tree view, custom meter layout (AllCPUs/Memory/Swap left,
Tasks/LoadAverage/Uptime right), 15ms delay, highlight megabytes.

### GTK

Adwaita-dark theme, Papirus icons, DejaVu Sans 10pt font, dark mode
preference enabled.

---

## Wayland Environment Variables

Set in `home.nix` via `home.sessionVariables`:

| Variable | Value | Purpose |
|----------|-------|---------|
| `XDG_SESSION_TYPE` | `"wayland"` | Declare Wayland session |
| `XDG_CURRENT_DESKTOP` | `"sway"` | Desktop environment hint |
| `NIXOS_OZONE_WL` | `"1"` | Electron apps (VS Code, etc.) |
| `MOZ_ENABLE_WAYLAND` | `"1"` | Firefox native Wayland |
| `QT_QPA_PLATFORM` | `"wayland;xcb"` | Qt apps (fallback to xcb) |
| `SDL_VIDEODRIVER` | `"wayland"` | SDL2 apps |
| `_JAVA_AWT_WM_NONREPARENTING` | `"1"` | Java apps |
| `CLUTTER_BACKEND` | `"wayland"` | Clutter toolkit |
| `GDK_BACKEND` | `"wayland"` | GTK apps |
| `XCURSOR_THEME` | `"Adwaita"` | Cursor theme |
| `XCURSOR_SIZE` | `"24"` | Cursor size |

---

## Dependency Ecosystem Summary

The setup automatically resolves complementary dependencies:

| Core App | Automatically Included Companions |
|----------|----------------------------------|
| sway | waybar, wofi, swaybg, swaylock, swayidle, mako, wlogout, grim, slurp, wl-clipboard, wlr-randr |
| kitty | FiraMono Nerd Font, zellij (auto-starts inside kitty) |
| zsh | oh-my-zsh (4 plugins), zsh-autosuggestions, zsh-syntax-highlighting, oh-my-posh, fzf |
| neovim | NvChad (66 plugins), LSPs (rust-analyzer, lua-ls, nil, ts-server, css/html/json), formatters (stylua) |
| yazi | fzf integration plugin, nvim as default editor |
| zellij | zjstatus plugin (custom WASM), kitty integration |
| development | gcc, cmake, pkg-config, openssl, rust/go/node/python toolchains |

---

## Changes Made (vs previous i3/X11 nix-config)

### X11 → Wayland Package Swaps

| X11 Package | Wayland Replacement |
|-------------|-------------------|
| `i3` | `sway` |
| `i3status` | `waybar` |
| `picom` | *(removed)* |
| `rofi` | `wofi` |
| `feh` | `swaybg` |
| `i3lock` / `betterlockscreen` | `swaylock` |
| `xss-lock` | `swayidle` |
| `nitrogen` | `swaybg` |
| `xclip` | `wl-clipboard` |
| `xdotool` | *(removed)* |
| `xorg.xrandr` | `wlr-randr` |
| `maim` / `slop` | `grim` / `slurp` |
| `dunst` | `mako` |
| `xfce4-panel` | *(removed)* |

### Removed files

- **`config/rofi/`** — Entire directory (~200 files: launchers, applets, powermenus, colors, scripts, images)
- **`.xsession`** — No longer needed (Sway manages its own session)
- **`config/rofi` references** — Removed from `xdg.configFile` in window-manager.nix

### Updated modules

| Module | Changes |
|--------|---------|
| `modules/window-manager.nix` | Complete rewrite: `xsession.windowManager.i3` → `wayland.windowManager.sway`; i3status → waybar; rofi → wofi; picom/dunst/xss-lock removed; added swayidle, mako, swaybg, sway-screenshot/ power/ toggle-lang scripts |
| `modules/desktop.nix` | Removed feh, i3lock, xss-lock, betterlockscreen, nitrogen, picom, xfce4-panel, xfce4-whiskermenu-plugin; added swaybg, swaylock, swayidle, wofi, waybar, mako, wl-clipboard, wlr-randr, grim, slurp, wlogout |
| `modules/packages.nix` | Removed xclip, xdotool, xorg.xrandr, xorg.xsetroot, maim, slop, nitrogen, dunst, betterlockscreen, xfce4-panel, xfce4-whiskermenu-plugin, picom; added wl-clipboard, wlr-randr, grim, slurp, wlogout, qtwayland |
| `home.nix` | Added comprehensive Wayland environment variables (XDG_SESSION_TYPE, MOZ_ENABLE_WAYLAND, NIXOS_OZONE_WL, QT_QPA_PLATFORM, etc.) |

### Preserved intact

- `modules/shell.nix` — Shell agnostic
- `modules/terminal.nix` — All tools work on Wayland
- `modules/editors.nix` — Terminal-based, no display server dependency
- `modules/development.nix` — Toolchain only
- `modules/git.nix` — No changes needed

---

## How to Apply

### On a new system:

```bash
# 1. Install Nix with flakes support
sh <(curl -L https://nixos.org/nix/install) --daemon
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf

# 2. Clone or copy this config

# 3. First-time Home Manager activation
cd ~/my-work/nix-config
nix run home-manager/master -- switch --flake .#ali

# 4. Subsequent updates
home-manager switch --flake .#ali
```

### On a non-NixOS Linux distro:

The flake is configured for standalone Home Manager and will work on any
Linux distro with Nix installed. Just follow steps 1-4 above.

### After deployment:

- Log out and log back in (or restart your display manager)
- Sway should start automatically (no `.xsession` needed — Sway session is handled by Home Manager)
- Kitty will auto-launch Zellij
- Lazy.nvim will fetch plugins on first Neovim launch
- Wofi is ready for app launching (`$mod+d`) and power management (`$mod+x`)

### Troubleshooting

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| Sway won't start | Missing session file | Log in to a TTY and run `sway` directly |
| Electron apps blank | Missing OZONE variable | `export NIXOS_OZONE_WL=1` (already in `home.nix`) |
| Firefox won't use Wayland | Missing MOZ variable | `export MOZ_ENABLE_WAYLAND=1` (already in `home.nix`) |
| Keyboard layout wrong | Sway input config | Run `swaymsg input type:keyboard xkb_layout us,ir` |
| Screenshot not working | Missing grim/slurp | `which grim && which slurp` |
| Clipboard not working | Missing wl-clipboard | `which wl-copy` |

---

## Files in `config/` That Must Stay in Sync

These directories are copies of your live config files. If you change a
config in `~/.config/`, update the corresponding file here:

| Live path | Nix config path |
|-----------|----------------|
| `~/.config/nvim/` | `config/nvim/` |
| `~/.config/zellij/layouts/` | `config/zellij/layouts/` |
| `~/.config/neofetch/config.conf` | `config/neofetch/config.conf` |

For all other configs (sway, waybar, wofi, mako, kitty, yazi keymap, zellij
config.kdl, btop, htop, tilda, xfce4-terminal), the config is embedded as
Nix strings in the module files themselves — edit the `.nix` file directly.

---

## Git Branches

```
main    ← current (Wayland/Sway)
x11-i3  ← original (X11/i3) — preserved for fallback
```

To view the full diff of the X11→Wayland transition:

```bash
git diff x11-i3..main
```

To switch back to i3:

```bash
git checkout x11-i3
home-manager switch --flake .#ali
```
