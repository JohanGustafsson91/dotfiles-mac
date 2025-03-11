#!/usr/bin/env bash

source $CONFIG_DIR/icon_map.sh 

# FONT="Monaspace Neon"
# FONT="Hack Nerd Font"
# FONT="MesloLGL Nerd Font Propo"
FONT="SF Pro"

# Get the list of running applications for the current workspace
running_apps=$(aerospace list-windows --workspace "$1" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}' | uniq | paste -sd ", " -)

# Create the label text based on the workspace and running apps
if [ -n "$running_apps" ]; then
    label_text="$1 - $running_apps"
else
    label_text="$1"
fi

apps=$(aerospace list-windows --workspace "$1" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}' | uniq)

icon_strip=""
if [ "${apps}" != "" ]; then
  while read -r app
  do
    __icon_map "$app"
    icon_strip+=" $icon_result"
  done <<< "${apps}"
else
  icon_strip=""
fi

# Use $sid as the identifier for the workspace (from the SketchyBar configuration)
sid=$1

if [ -z "$FOCUSED_WORKSPACE" ]; then
    FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

# echo "DEBUG: sid=$sid, label_text=$label_text font=$FONT value=$FOCUSED_WORKSPACE v=$1" 

LABEL="${icon_strip}"

# Set the background drawing and label based on the focused workspace
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    # Highlight the active workspace with Tokyo Night styling
    sketchybar --set space.$sid \
        background.drawing=on \
        icon.color=0xffffffff  \
        label.color=0xffffffff  \
        icon="$1" \
        background.color=0xff020d18 \
        icon.font="$FONT:bold:12.0" \
        label="$LABEL"
else
    # Normal state for inactive workspaces
    sketchybar --set space.$sid \
        background.drawing=on \
        label="$LABEL" \
        icon="$1" \
        icon.color=0xff627e97 \
        color=0xff627e97 \
        label.color=0xff627e97 \
        background.color=0xff020d18
fi
