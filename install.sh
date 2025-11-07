#!/bin/bash

set -e

# Color output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo -e "${BLUE}Dotfiles directory: ${DOTFILES_DIR}${NC}"

# install brew
echo -e "${GREEN}Installing Homebrew...${NC}"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

echo -e "${GREEN}Installing packages from Brewfile...${NC}"
brew bundle --file="${DOTFILES_DIR}/Brewfile"

# Change to zsh
echo -e "${GREEN}Setting up zsh...${NC}"
chsh -s /bin/zsh

# NVM
echo -e "${GREEN}Setting up NVM...${NC}"
mkdir -p ~/.nvm
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc

# Oh My Zsh
echo -e "${GREEN}Installing Oh My Zsh...${NC}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k
echo -e "${GREEN}Installing Powerlevel10k...${NC}"
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc

# Zsh plugins
echo -e "${GREEN}Setting up zsh plugins...${NC}"
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

# Function to safely create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo -e "${BLUE}Backing up existing $target to ${target}.backup${NC}"
        mv "$target" "${target}.backup"
    fi
    
    echo -e "${GREEN}Creating symlink: $target -> $source${NC}"
    ln -sf "$source" "$target"
}

# Setup config directory
mkdir -p ~/.config

# Define dotfiles to symlink: "source:target"
DOTFILES=(
    "nvim:.config/nvim"
    "alacritty:.config/alacritty"
    "sketchybar:.config/sketchybar"
    "scripts:.config/scripts"
    "borders:.config/borders"
    "aerospace.toml:.aerospace.toml"
    "aliases:.zsh_aliases"
    ".tmux.conf:.tmux.conf"
)

# Create symlinks for dotfiles
echo -e "${GREEN}Creating symlinks...${NC}"

for item in "${DOTFILES[@]}"; do
    source_name="${item%%:*}"
    target_path="${item##*:}"
    create_symlink "${DOTFILES_DIR}/${source_name}" ~/${target_path}
done

# Alacritty themes (clone into alacritty directory)
if [ ! -d "${DOTFILES_DIR}/alacritty/themes/.git" ]; then
    echo -e "${GREEN}Cloning Alacritty themes...${NC}"
    git clone https://github.com/alacritty/alacritty-theme "${DOTFILES_DIR}/alacritty/themes"
    curl https://raw.githubusercontent.com/josean-dev/dev-environment-files/main/.config/alacritty/themes/themes/coolnight.toml --output "${DOTFILES_DIR}/alacritty/themes/themes/coolnight.toml"
fi

# Source aliases in zshrc
if ! grep -q "source ~/.zsh_aliases" ~/.zshrc; then
    echo "[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases" >> ~/.zshrc
fi

# Tmux plugin manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo -e "${GREEN}Installing Tmux Plugin Manager...${NC}"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install node via nvm
echo -e "${GREEN}Installing Node.js via NVM...${NC}"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install node

# macOS Settings
echo -e "${GREEN}Applying macOS settings...${NC}"

# Aerospace
defaults write com.apple.dock expose-group-apps -bool true
defaults write com.apple.spaces spans-displays -bool true
defaults write -g com.apple.keyboard.fnState -bool true
defaults write com.apple.dock autohide -bool true

# Keyboard
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10

# Theme
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
defaults write com.apple.dock showDesktopGestureEnabled -bool false
defaults write com.apple.dock launchanim -bool false

# Restart affected services
killall Dock
killall SystemUIServer

echo -e "${GREEN}Done! Please restart your terminal.${NC}"
echo -e "${BLUE}Note: Your dotfiles are now symlinked. Any changes you make will be reflected in ${DOTFILES_DIR}${NC}"
