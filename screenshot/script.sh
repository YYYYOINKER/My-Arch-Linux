#!/bin/bash

# Define the constant path for the screenshot
screenshot_path="$HOME/Pictures/Screenshots"
mkdir -p "$screenshot_path"  # Ensure the directory exists
file="$screenshot_path/screenshot.png"

# Use flameshot to take a screenshot with GUI mode
# and save it to the specified file
flameshot gui --raw > "$file"

# No need to check if the screenshot was taken, flameshot will not
# produce a file if the screenshot is not taken (e.g., if the user cancels the selection).

# Since flameshot does not have built-in clipboard support when saving to file
# in command line mode, use xclip to copy the screenshot to the clipboard
if [ -f "$file" ]; then
    xclip -selection clipboard -target image/png -i "$file"
fi

