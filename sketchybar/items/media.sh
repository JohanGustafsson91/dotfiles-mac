#!/bin/bash

sketchybar --add item media right \
           --set media label.color=$LABEL_COLOR \
                       label.max_chars=20 \
                       icon.padding_left=0 \
                       icon.padding_right=10 \
                       scroll_texts=on \
                       icon.font="sketchybar-app-font:Regular:16.0" \
                       icon=":playing:"         \
                       icon.color=$LABEL_COLOR   \
                       background.drawing=off \
                       script="$PLUGIN_DIR/media.sh" \
           --subscribe media media_change
