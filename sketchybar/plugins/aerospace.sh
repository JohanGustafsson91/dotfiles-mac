#!/usr/bin/env bash

source $CONFIG_DIR/icon_map.sh 

# FONT="Monaspace Neon"
# FONT="Hack Nerd Font"
FONT="MesloLGL Nerd Font Propo"
# FONT="SF Pro"

apps=$(aerospace list-windows --workspace "$1" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}' | uniq)

icon_strip=""
if [ "${apps}" != "" ]; then
  while read -r app
  do
    __icon_map "$app"
    icon_strip+="$icon_result"
  done <<< "${apps}"
else
  icon_strip=""
fi

sid=$1

if [ -z "$FOCUSED_WORKSPACE" ]; then
    FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

LABEL="${icon_strip}"

if [ -n "$icon_strip" ]; then
  padding_right=10
else
  padding_right=0
fi

# Set the background drawing and label based on the focused workspace
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    # Highlight the active workspace with Tokyo Night styling
    sketchybar --set space.$sid \
        background.drawing=on \
        icon.color=0xffffffff  \
        label.color=0xffffffff  \
        icon="$1" \
        background.color=0x00000000 \
        icon.font="$FONT:bold:12.0" \
        label="$LABEL" \
        label.padding_right="$padding_right"
else
    # Normal state for inactive workspaces
    sketchybar --set space.$sid \
        background.drawing=off \
        label="$LABEL" \
        icon="$1" \
        icon.color=0xff627e97 \
        color=0xff627e97 \
        label.color=0xff627e97 \
        background.color=0x00000000 \
        label.padding_right="$padding_right"
fi
