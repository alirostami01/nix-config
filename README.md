# Nix Configuration

Personal, declarative Linux user-environment configuration managed with **Nix Flakes** and **Home Manager**.

## Features

- Reproducible user-environment configuration
- Nix Flakes with `nixpkgs` unstable
- Home Manager integration
- Modular configuration for desktop, window manager, shell, terminal, editors, development, Git, and packages
- Wayland/Sway environment configuration
- Unfree packages enabled

## Structure

```text
.
├── flake.nix
├── flake.lock
├── home.nix
└── modules/
    ├── desktop.nix
    ├── development.nix
    ├── editors.nix
    ├── git.nix
    ├── packages.nix
    ├── shell.nix
    ├── terminal.nix
    └── window-manager.nix
```

## Requirements

- Nix with Flakes enabled
- Home Manager
- Linux (`x86_64-linux`)

## Apply Configuration

Clone the repository and switch to the Home Manager configuration:

```bash
git clone https://github.com/alirostami01/nix-config.git
cd nix-config
nix run github:nix-community/home-manager -- switch --flake .#ali
```

After making changes, apply the configuration again with the same command.

## Notes

This is a personal configuration and is primarily intended for my own Linux environment. Feel free to use it as a reference or adapt individual modules for your setup.

## License

Personal configuration. See the repository history for details.
