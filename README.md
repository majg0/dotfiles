# Dotfiles

My modular dotfiles; currently OS X only.

Each directory is a mod.

The function `runmods` in `common.sh` executes every file of a given name from each mod in lexicographical module order.
Mod dependencies are therefore simply handled by prefixing 1_, 2_, etc.

By convention, configuration files go into each mod's `data` folder.

Linking and installing will both each automatically export environment variables before starting.

## Usage

1. Clone anywhere.
2. `./link.sh`.
3. `./install.sh`.

## Scripts

- `env.sh` exports environment variables; sourced by `.zshenv`.
- `link.sh` runs `env.sh` and links configuration files into system folders.
- `install.sh` runs `env.sh` and installs remote files onto the system.
- `alias.sh` defines aliases from mods and the optional `~/.aliases` file; sourced by `.zshrc`.
- `rc.sh` runs commands at shell startup; sourced by `.zshrc`.
