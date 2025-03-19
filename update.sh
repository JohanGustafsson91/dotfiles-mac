#!/bin/bash

echo "Copy aerospace"
cp ~/.config/aerospace/aerospace.toml aerospace.toml 

echo "Copy nvim"
cp -r ~/.config/nvim/ nvim

echo "Copy tmux"
cp -r ~/.tmux.conf .tmux.conf

echo "Copy scripts"
cp -r ~/.config/scripts/ scripts

echo "Copy aliases"
cp ~/.zsh_aliases aliases

echo "Copy sketchybar"
cp -r ~/.config/sketchybar/ sketchybar

echo "Copy alacritty"
cp -r ~/.config/alacritty/ alacritty

echo "Copy borders"
cp -r ~/.config/borders/ borders
