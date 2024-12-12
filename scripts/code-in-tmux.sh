#!/bin/bash

# Get the current directory name and sanitize it
SESSION_NAME=$(basename "$PWD" | tr '.' '_')

echo "Sanitized session name: $SESSION_NAME"

# Check if the session already exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null
if [ $? != 0 ]; then
    echo "Creating new session: $SESSION_NAME"
    # Create a new session
    tmux new-session -d -s "$SESSION_NAME" || { echo "Failed to create session"; exit 1; }

    # Open vim in the first window
    tmux send-keys -t "$SESSION_NAME:0" 'nvim' C-m || { echo "Failed to open vim"; exit 1; }

    # Create a new window named "terminals"
    tmux new-window -t "$SESSION_NAME:1" -n "terminals" || { echo "Failed to create terminals window"; exit 1; }

    # Split the "terminals" window into two panes
    tmux split-window -h -t "$SESSION_NAME:1" || { echo "Failed to split terminals window"; exit 1; }

    # Optionally send initial commands to panes
    # tmux send-keys -t "$SESSION_NAME:1.0" 'echo "Left pane"' C-m
    # tmux send-keys -t "$SESSION_NAME:1.1" 'echo "Right pane"' C-m
else
    echo "Session $SESSION_NAME already exists."
fi

# Switch to the vim window (first tab)
tmux select-window -t "$SESSION_NAME:0" || { echo "Failed to select vim window"; exit 1; }

# Check if inside tmux
if [ -z "$TMUX" ]; then
    echo "Not inside tmux, attaching to session: $SESSION_NAME"
    tmux attach -t "$SESSION_NAME"
else
    echo "Already inside tmux, switching to session: $SESSION_NAME"
    tmux switch-client -t "$SESSION_NAME"
fi
