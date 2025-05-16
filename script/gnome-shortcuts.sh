#!/bin/bash

# Define the custom keybinding name and command
KEY_NAME="custom0"
KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
KEY_FULL_PATH="${KEY_PATH}/${KEY_NAME}/"

# Terminal command (change if you're using a different terminal)
TERMINAL_COMMAND="ghostty"

# Get existing custom keybindings
existing=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

# If the current value is empty or "[]", set it to a new array with our path
if [[ "$existing" == "@as []" || "$existing" == "[]" ]]; then
    new_list="['${KEY_FULL_PATH}']"
else
    # Check if the custom key already exists
    if [[ "$existing" != *"$KEY_FULL_PATH"* ]]; then
        # Remove leading and trailing brackets
        trimmed=${existing:1:-1}
        # Add our new keybinding
        new_list="[${trimmed}, '${KEY_FULL_PATH}']"
    else
        new_list="$existing"
    fi
fi

# Set the updated list of custom keybindings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$new_list"

# Set the keybinding details
gsettings set "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_FULL_PATH}" name "Launch Terminal"
gsettings set "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_FULL_PATH}" command "${TERMINAL_COMMAND}"
gsettings set "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${KEY_FULL_PATH}" binding "<Super>Return"

