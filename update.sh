#!/bin/bash

echo "Copy aerospace"
cp ~/.config/aerospace/aerospace.toml aerospace.toml 

echo "Copy nvim"
cp -r ~/.config/nvim/ nvim

echo "Copy tmux"
cp -r ~/.tmux.conf .tmux.conf
