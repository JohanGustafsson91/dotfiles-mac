# Dotfiles MAC

My personal macOS dotfiles managed with symlinks.

## What's included

- **nvim**: Neovim configuration
- **alacritty**: Terminal emulator config
- **tmux**: Terminal multiplexer config
- **aerospace**: Window manager config
- **sketchybar**: Status bar config
- **borders**: Window borders config
- **scripts**: Utility scripts for tmux and project management
- **aliases**: Shell aliases
- **Brewfile**: Homebrew packages and applications

## Installation

### Already have your machine setup?

If your machine is already configured and you just want to switch to symlink management:

1. Clone this repository (if you haven't already):
   ```bash
   git clone https://github.com/JohanGustafsson91/dotfiles-mac.git ~/code/dotfiles
   cd ~/code/dotfiles
   ```

2. Run the symlink setup script:
   ```bash
   ./setup-symlinks.sh
   ```

This will:
- Backup your existing configs with `.backup` suffix
- Create symlinks from your home directory to this repo
- Preserve all your current settings

### Fresh machine setup

1. Clone this repository:
   ```bash
   git clone https://github.com/JohanGustafsson91/dotfiles-mac.git ~/code/dotfiles
   cd ~/code/dotfiles
   ```

2. Run the full install script:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. Restart your terminal

### What the install script does

- Installs Homebrew and all packages from Brewfile
- Sets up zsh with Oh My Zsh and Powerlevel10k theme
- Creates symlinks from this repo to your home directory
- Configures macOS settings (dock, keyboard, etc.)
- Installs NVM and Node.js

## How it works

This setup uses **symlinks** instead of copying files. This means:

- Changes you make to configs are automatically reflected in the git repo
- No need to run update scripts - just commit and push
- Works across multiple machines - just pull the latest changes
- Your existing configs are backed up with a `.backup` suffix

### Symlink structure

```
~/.config/nvim        -> ~/code/dotfiles/nvim
~/.config/alacritty   -> ~/code/dotfiles/alacritty
~/.config/sketchybar  -> ~/code/dotfiles/sketchybar
~/.config/scripts     -> ~/code/dotfiles/scripts
~/.config/borders     -> ~/code/dotfiles/borders
~/.aerospace.toml     -> ~/code/dotfiles/aerospace.toml
~/.zsh_aliases        -> ~/code/dotfiles/aliases
~/.tmux.conf          -> ~/code/dotfiles/.tmux.conf
```

## Updating configs

Just edit the files as normal and commit:

```bash
cd ~/code/dotfiles
git add .
git commit -m "Update nvim config"
git push
```

## Syncing to another machine

```bash
cd ~/code/dotfiles
git pull
```

That's it! Since configs are symlinked, pulling updates immediately applies them.

## Uninstalling

To remove symlinks and restore original configs:

```bash
cd ~
for link in .config/nvim .config/alacritty .config/sketchybar .config/scripts .config/borders .aerospace.toml .zsh_aliases .tmux.conf; do
    if [ -L "$link" ]; then
        rm "$link"
        [ -e "${link}.backup" ] && mv "${link}.backup" "$link"
    fi
done
```
