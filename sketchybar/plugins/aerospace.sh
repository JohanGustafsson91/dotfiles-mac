#!/usr/bin/env bash

source $CONFIG_DIR/icon_map.sh 
source $CONFIG_DIR/colors.sh 

FONT="MesloLGL Nerd Font Propo"


if [ -z "$FOCUSED_WORKSPACE" ]; then
    FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

apps=$(aerospace list-windows --workspace "$1" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}' | uniq)

LABEL=""
if [ "${apps}" != "" ]; then
  while read -r app
  do
    __icon_map "$app"
    LABEL+="$icon_result"
  done <<< "${apps}"
else
  LABEL=""
fi

if [ -n "$icon_strip" ]; then
  padding_right=10
else
  padding_right=0
fi

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set space.$1 \
        background.drawing=on \
        icon.color="$WHITE"  \
        label.color="$WHITE"  \
        icon="$1" \
        background.color="$BAR_COLOR" \
        icon.font="$FONT:bold:12.0" \
        label="$LABEL" \
        label.padding_right="$padding_right"
else
    sketchybar --set space.$1 \
        background.drawing=off \
        label="$LABEL" \
        icon="$1" \
        icon.color="$LABEL_INACTIVE_COLOR" \
        label.color="$LABEL_INACTIVE_COLOR" \
        background.color="$BAR_COLOR" \
        label.padding_right="$padding_right"
fi
