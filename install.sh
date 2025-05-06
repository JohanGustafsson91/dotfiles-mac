# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew bundle --file=./Brewfile

# Change to zsh
chsh -s /bin/zsh
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile

# NVM
mkdir ~/.nvm
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
nvm install node

# Clone dotfiles
mkdir code
cd code
git clone https://github.com/JohanGustafsson91/dotfiles-mac.git ~/code/dotfiles-mac
cd dotfiles-mac/

# Setup config
mkdir -p ~/.config
cp -R ~/code/dotfiles-mac/nvim ~/.config/nvim

cp -R ~/code/dotfiles-mac/alacritty ~/.config/alacritty
cd ~/.config/alacritty
git clone https://github.com/alacritty/alacritty-theme themes
curl https://raw.githubusercontent.com/josean-dev/dev-environment-files/main/.config/alacritty/themes/themes/coolnight.toml --output ~/.config/alacritty/themes/themes/coolnight.toml
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
echo "ZSH_THEME="powerlevel10k/powerlevel10k"" >> ~/.zshrc

cp -R ~/code/dotfiles-mac/aerospace.toml ~/.aerospace.toml

cp -R ~/code/dotfiles-mac/aliases ~/.zsh_aliases
echo "[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases" >> ~/.zshrc

cp -R ~/code/dotfiles-mac/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

cp -R ~/code/dotfiles-mac/scripts/ ~/.config/scripts/

cp -R ~/code/dotfiles-mac/borders/ ~/.config/borders/

# Settings

# Aerospace
defaults write com.apple.dock expose-group-apps -bool true && killall Dock
defaults write com.apple.spaces spans-displays -bool true && killall SystemUIServer
defaults write -g com.apple.keyboard.fnState -bool true
defaults write com.apple.dock autohide -bool true && killall Dock

# Keyboard
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10

# Theme
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
defaults write com.apple.dock showDesktopGestureEnabled -bool false && killall Dock
defaults write com.apple.dock launchanim -bool false && killall Dock
