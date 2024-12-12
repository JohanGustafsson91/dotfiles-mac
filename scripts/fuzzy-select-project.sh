#!/bin/bash

selected_dir=$(find ~/code -path "*/node_modules" -prune -o -maxdepth 3 \( -type f -name "package.json" -o -type d -name ".git" \) -exec dirname {} \; | sort -u | fzf --prompt="Select project: ")

if [[ -z "$selected_dir" ]]; then
  echo "No folder selected."
  exit 1
fi

cd "$selected_dir" || exit

echo "Run script from: $selected_dir"
bash ~/.config/scripts/code-in-tmux.sh
