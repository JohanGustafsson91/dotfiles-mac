#!/bin/bash

# Extract the "Output Source" for the default output device
active_output=$(system_profiler SPAudioDataType | awk '
    /Default Output Device: Yes/ {found=1} 
    found && /Output Source:/ {print $3; exit}
')

# Print the result
if [[ -n "$active_output" ]]; then
    echo "Aktiv ljudutgång: $active_output"
else
    echo "Ingen aktiv ljudutgång hittades."
fi

sketchybar --set "$NAME" label="$active_output" click_script="open x-apple.systempreferences:com.apple.Sound-Settings.extension"
