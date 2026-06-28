# Home Manager Configuration — Ali Rostami

This document describes the complete modular Home Manager setup for migrating Ali Rostami's desktop
environment to a new Nix-powered system. Every application, plugin, package, and configuration
setting is captured declaratively.

---

## Architecture Overview

```
nix-config/
├── flake.nix                          # Nix flake entry point
├── home.nix                           # Top-level config, imports all modules
├── DOCS.md                            # This document
├── modules/
│   ├── window-manager.nix             # i3 + i3status + picom + rofi
│   ├── shell.nix                      # zsh + oh-my-zsh + oh-my-posh + bash + fzf + neofetch
│   ├── terminal.nix                   # kitty + zellij + yazi + tilda + btop + htop
│   ├── editors.nix                    # neovim (NvChad v2.5, 50+ Lua files)
│   ├── development.nix                # LSPs, dev toolchains, lazygit
│   ├── git.nix                        # git + git-lfs user config
│   ├── desktop.nix                    # GTK, fonts, betterlockscreen, nitrogen, mime, user-dirs
│   └── packages.nix                   # 50+ CLI / media / network / misc packages
├── config/
│   ├── nvim/                          # NvChad Lua config (50 files, 66 plugins)
│   ├── rofi/                          # adi1090x launchers, applets, powermenu, colors
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
| `window-manager.nix` | `xsession.windowManager.i3`, `programs.i3status`, `services.picom`, `programs.rofi` |
| `shell.nix` | `programs.zsh`, `programs.bash`, `programs.fzf`, `xdg.configFile` for oh-my-posh & neofetch |
| `terminal.nix` | `programs.kitty`, `programs.zellij`, `programs.yazi`, plus `xdg.configFile` for btop, htop, tilda, keymaps |
| `editors.nix` | `programs.neovim`, `home.file.".config/nvim"` (recursive copy) |
| `development.nix` | LSPs, rust/go/node toolchains, `programs.lazygit` |
| `git.nix` | `programs.git` with user.name, user.email, LFS |
| `desktop.nix` | GTK, fonts, `services.network-manager-applet`, `xdg.mimeApps`, `xdg.userDirs`, desktop utilities |
| `packages.nix` | All other CLI and misc packages |

---

## All Installed Packages

### Window Manager & Desktop

| Package | Purpose |
|---------|---------|
| `i3` | Tiling window manager (via `xsession.windowManager.i3`) |
| `i3status` | Status bar (WiFi, CPU, RAM, disk, volume, time, kb layout) |
| `picom` | X11 compositor (GLX backend, opacity rules) |
| `rofi` | Application launcher, powermenu, screenshot |
| `feh` | Wallpaper setter |
| `i3lock` / `betterlockscreen` | Screen locker |
| `xss-lock` | Suspend-then-lock on sleep |
| `networkmanagerapplet` | System tray network manager |
| `dex` | Desktop file autostart |
| `nitrogen` | Wallpaper manager (GUI) |
| `xfce4-panel` | Desktop panel (toggleable) |
| `thunar` | GUI file manager |
| `xfce4-terminal` | Alternative GTK terminal |
| `xfce4-whiskermenu-plugin` | Application menu for xfce4-panel |
| `mako` | Notification daemon |

### Terminal & Shell

| Package | Purpose |
|---------|---------|
| `kitty` | Primary GPU-accelerated terminal |
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
| `xclip` / `xdotool` | X11 clipboard / automation |
| `maim` / `slop` | Screenshot tool |
| `curl` / `wget` | HTTP clients |
| `nmap` / `iperf3` | Network diagnostics |
| `brightnessctl` | Backlight control |
| `playerctl` | Media player control |
| `pavucontrol` / `pulseaudio` | Audio control |
| `libnotify` / `dunst` | Desktop notifications |
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

### i3 Window Manager (`modules/window-manager.nix`)

**Key bindings:**
| Key | Action |
|-----|--------|
| `$mod+Return` | Launch kitty |
| `$mod+d` | Application launcher (rofi type-2) |
| `$mod+Space` | Toggle US / Persian keyboard layout |
| `$mod+r` | Resize mode |
| `Print` | Screenshot via rofi applet |
| `$mod+x` | Power menu via rofi applet |
| `$mod+1-4` | Switch workspace (web, dev, apps, temp) |
| `XF86Audio*` | Volume control via amixer |

**Colors:** Nord palette (`#2E3440` background, `#81a1c1` accent).  
**Gaps:** 15px inner, 5px outer.  
**Startup:** picom, nm-applet, feh wallpaper, xss-lock, keyboard layout.

### i3status Bar

Modules in order: WiFi, Ethernet, CPU temp, memory, load, disk `/`, keyboard
layout (read from `/tmp/kb_layout`), time, volume. Nord color-coded status.

### Picom Compositor

GLX backend, 90% opacity for terminals (kitty, Alacritty, xfce4-terminal),
95% for URxvt, 100% for Thunar.

### Rofi

7 launcher types, 6 powermenu types, 16 color schemes, applets for
brightness/battery/screenshot/volume/MPD. Default uses `config.rasi` from
the copied rofi directory.

### Kitty Terminal

FiraMono Nerd Font 12pt, no title bar, copy-on-select, no shell title
integration.

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

### betterlockscreen

Nord-themed colors, transparent interior, `#d8dee9` key highlight.

### GTK

Adwaita-dark theme, Papirus icons, DejaVu Sans 10pt font, dark mode
preference enabled.

---

## Dependency Ecosystem Summary

The setup automatically resolves complementary dependencies:

| Core App | Automatically Included Companions |
|----------|----------------------------------|
| i3 | i3status, picom, rofi, feh, i3lock/xss-lock, nm-applet, dex |
| kitty | FiraMono Nerd Font, zellij (auto-starts inside kitty) |
| zsh | oh-my-zsh (4 plugins), zsh-autosuggestions, zsh-syntax-highlighting, oh-my-posh, fzf |
| neovim | NvChad (66 plugins), LSPs (rust-analyzer, lua-ls, nil, ts-server, css/html/json), formatters (stylua) |
| yazi | fzf integration plugin, nvim as default editor |
| zellij | zjstatus plugin (custom WASM), kitty integration |
| development | gcc, cmake, pkg-config, openssl, rust/go/node/python toolchains |

---

## Changes Made (vs previous nix-config)

### Added new app configs (merged from current `~/.config/`)

| File | Content |
|------|---------|
| `modules/terminal.nix` | **NEW** btop config, htop config, tilda x2 configs, yazi keymap.toml, zellij layouts dir |
| `modules/desktop.nix` | **NEW** betterlockscreen config, nitrogen config, xfce4-terminal config, `xdg.mimeApps`, `xdg.userDirs` |
| `modules/shell.nix` | **NEW** neofetch 864-line config |
| `modules/packages.nix` | **NEW** btop, tilda, betterlockscreen, nitrogen, neofetch, xfce4-terminal, xfce4-whiskermenu-plugin, dust (renamed from du-dust) |

### Updated existing modules

| File | Changes |
|------|---------|
| `home.nix` | `stateVersion` bumped from `24.05` → `24.11` |
| `modules/desktop.nix` | Added `gtk3.bookmarks`, `nitrogen` and `betterlockscreen` to packages |
| `modules/packages.nix` | Fixed `du-dust` → `dust` (correct nixpkgs name), removed duplicate `btop` |

### Refreshed config directories

- `config/nvim/` — Re-copied from dotfiles to capture any changes
- `config/zellij/layouts/` — New directory with clean.kdl + default.kdl

---

## How to Apply

### On a new NixOS system:

```bash
# 1. Install Nix with flakes support
sh <(curl -L https://nixos.org/nix/install) --daemon
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf

# 2. Clone or copy this config
#    (if on the same machine, it's already at ~/my-work/nix-config)

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
- i3 should start automatically via `.xsession`
- Kitty will auto-launch Zellij
- Lazy.nvim will fetch plugins on first Neovim launch
- Rofi themes/applets are deployed from the copied directory

---

## Files in `config/` That Must Stay in Sync

These directories are copies of your live config files. If you change a
config in `~/.config/`, update the corresponding file here:

| Live path | Nix config path |
|-----------|----------------|
| `~/.config/nvim/` | `config/nvim/` |
| `~/.config/rofi/{launchers,applets,colors}` | `config/rofi/{launchers,applets,colors}` |
| `~/.config/zellij/layouts/` | `config/zellij/layouts/` |
| `~/.config/neofetch/config.conf` | `config/neofetch/config.conf` |

For all other configs (kitty, i3, i3status, picom, yazi keymap, zellij
config.kdl, btop, htop, tilda, betterlockscreen, nitrogen, xfce4-terminal),
the config is embedded as Nix strings in the module files themselves —
edit the `.nix` file directly.
