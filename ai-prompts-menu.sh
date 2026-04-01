#!/bin/bash
# Wayland-native AI prompts popup menu
# Triggered via GNOME custom keyboard shortcut (Ctrl+Shift+M)
# Uses rofi for menu selection, ydotool to type text at cursor

declare -A PROMPTS

PROMPTS["Save for Claude Restart"]="Please save everything to memory, so I can stop Claude code and then restart from exactly the same place."
PROMPTS["Summarize This Code"]="Please provide a brief summary of what this code does, its inputs, outputs, and any important side effects."
PROMPTS["Find Bugs in This Code"]="Please review this code for bugs, edge cases, and potential issues. List each issue with its severity and a suggested fix."
PROMPTS["Write Tests for This"]="Please write comprehensive tests for this code, covering normal cases, edge cases, and error conditions."
PROMPTS["Explain This Error"]="Please explain what this error means, what likely caused it, and how to fix it."
PROMPTS["Continue Claude"]="Continue where you left off."
PROMPTS["Create Git Repo"]="Create a new repo on GitHub using the GITHUB_TOKEN env var.  Then, create a deploy key that accesses only this repository, and save it within this directory.  Commit all appropriate files from this directory to the new repo.  As a standing order, always commit and push and save to memory whenever a new feature is successfully added; in the future, do this autonomously without being asked. Try to commit after successful tests, try to avoid commiting when in a broken state. I may likely delete the contents of this directory at some point, then, when I want to continue work, I will clone from GitHub, so please make sure enough files are tracked to allow continuing right from where I left off (including memories). The default user is Phil Koh pk14225@gmail.com. The name of the new repo is: "
PROMPTS["Edit This Menu"]="Please edit the AI prompts menu script at /home/phil/ClaudeAddMenu/ai-prompts-menu.sh to add, remove, or modify menu items per my instructions below. The menu items are defined in two places in that file that must be kept in sync: (1) the PROMPTS associative array near the top, where each entry is PROMPTS[\"Menu Label\"]=\"text to insert\", and (2) the OPTIONS variable which lists the menu labels in display order, one per line. To add a new item, add a PROMPTS line and add the label to OPTIONS. To remove one, delete it from both. To modify the inserted text, edit the PROMPTS value. Here is what I would like you to change:"

# Display order
OPTIONS="Save for Claude Restart
Summarize This Code
Find Bugs in This Code
Write Tests for This
Explain This Error
Continue Claude
Create Git Repo
Edit This Menu"

# Show rofi menu with single-click selection
CHOICE=$(echo "$OPTIONS" | rofi -dmenu -i -p "AI Prompts" \
    -me-select-entry '' \
    -me-accept-entry 'MousePrimary' \
    -theme-str 'window {width: 400px;}')

# Exit if nothing selected
[ -z "$CHOICE" ] && exit 0
[ -z "${PROMPTS[$CHOICE]}" ] && exit 0

# Write selected prompt to a temp file (avoids shell quoting issues)
TMPFILE=$(mktemp /tmp/ai-prompt-XXXXXX.txt)
printf '%s' "${PROMPTS[$CHOICE]}" > "$TMPFILE"

# Type the text at cursor position using ydotool
# --delay 250: wait 250ms for rofi to close and focus to return
# --key-delay 5: 5ms between keystrokes to avoid dropped characters
sudo ydotool type --delay 250 --key-delay 5 --file "$TMPFILE" 2>/dev/null

rm -f "$TMPFILE"
