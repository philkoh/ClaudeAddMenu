#!/bin/bash
# Wayland-native AI prompts popup menu
# Triggered via GNOME custom keyboard shortcut (Ctrl+Shift+M)
# Uses rofi for menu selection, ydotool to type text at cursor
# Reads prompts from shared prompts.json

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROMPTS_FILE="$SCRIPT_DIR/prompts.json"

if [ ! -f "$PROMPTS_FILE" ]; then
    notify-send "AI Prompts" "prompts.json not found" 2>/dev/null
    exit 1
fi

# Build menu from JSON (requires jq)
OPTIONS=$(jq -r '.[].label' "$PROMPTS_FILE")

# Show rofi menu with single-click selection
CHOICE=$(echo "$OPTIONS" | rofi -dmenu -i -p "AI Prompts" \
    -me-select-entry '' \
    -me-accept-entry 'MousePrimary' \
    -theme-str 'window {width: 400px;}')

# Exit if nothing selected
[ -z "$CHOICE" ] && exit 0

# Look up the prompt text from JSON
PROMPT_TEXT=$(jq -r --arg label "$CHOICE" '.[] | select(.label == $label) | .text' "$PROMPTS_FILE")
[ -z "$PROMPT_TEXT" ] && exit 0

# Write selected prompt to a temp file (avoids shell quoting issues)
TMPFILE=$(mktemp /tmp/ai-prompt-XXXXXX.txt)
printf '%s' "$PROMPT_TEXT" > "$TMPFILE"

# Type the text at cursor position using ydotool
# --delay 250: wait 250ms for rofi to close and focus to return
# --key-delay 5: 5ms between keystrokes to avoid dropped characters
sudo ydotool type --delay 250 --key-delay 5 --file "$TMPFILE" 2>/dev/null

rm -f "$TMPFILE"
