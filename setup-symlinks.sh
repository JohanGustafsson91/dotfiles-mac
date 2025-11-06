#!/bin/bash

set -e

# Color output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}Dotfiles Symlink Setup${NC}"
echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}Dotfiles directory: ${DOTFILES_DIR}${NC}"
echo ""

# Function to safely create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Check if source exists
    if [ ! -e "$source" ]; then
        echo -e "${RED}✗ Source does not exist: $source${NC}"
        return 1
    fi
    
    # If target is already a symlink pointing to the correct location
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        echo -e "${GREEN}✓ Already linked: $target${NC}"
        return 0
    fi
    
    # If target exists (file or directory or wrong symlink)
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo -e "${YELLOW}⚠ Backing up existing: $target -> ${target}.backup${NC}"
        
        # If backup already exists, add timestamp
        if [ -e "${target}.backup" ]; then
            timestamp=$(date +%Y%m%d_%H%M%S)
            mv "$target" "${target}.backup.${timestamp}"
            echo -e "${BLUE}  (Created timestamped backup)${NC}"
        else
            mv "$target" "${target}.backup"
        fi
    fi
    
    echo -e "${GREEN}✓ Creating symlink: $target -> $source${NC}"
    ln -sf "$source" "$target"
}

# Ensure .config directory exists
mkdir -p ~/.config

echo -e "${BLUE}Creating symlinks...${NC}"
echo ""

# Create symlinks for dotfiles
create_symlink "${DOTFILES_DIR}/nvim" ~/.config/nvim
create_symlink "${DOTFILES_DIR}/alacritty" ~/.config/alacritty
create_symlink "${DOTFILES_DIR}/sketchybar" ~/.config/sketchybar
create_symlink "${DOTFILES_DIR}/scripts" ~/.config/scripts
create_symlink "${DOTFILES_DIR}/borders" ~/.config/borders
create_symlink "${DOTFILES_DIR}/aerospace.toml" ~/.aerospace.toml
create_symlink "${DOTFILES_DIR}/aliases" ~/.zsh_aliases
create_symlink "${DOTFILES_DIR}/.tmux.conf" ~/.tmux.conf

echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Setup complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo -e "${BLUE}Your dotfiles are now symlinked.${NC}"
echo -e "${BLUE}Any changes you make will be automatically reflected in:${NC}"
echo -e "${BLUE}${DOTFILES_DIR}${NC}"
echo ""
echo -e "${YELLOW}Note: Your original files have been backed up with .backup suffix${NC}"
echo -e "${YELLOW}You may want to verify everything works, then delete the backups.${NC}"
echo ""
echo -e "${BLUE}To see what's linked:${NC}"
echo -e "  ls -la ~/.config/nvim"
echo -e "  ls -la ~/.aerospace.toml"
echo -e "  ls -la ~/.tmux.conf"
echo ""
