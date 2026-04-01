#!/bin/bash
# Setup script for AutoKey "Common AI Prompts" menu
# Installs AutoKey (if needed) and configures a hotkey-triggered popup menu
# with AI prompt phrases that get pasted at the cursor.

set -e

AUTOKEY_DATA_DIR="$HOME/.config/autokey/data"
FOLDER_NAME="Common AI Prompts"
FOLDER_DIR="$AUTOKEY_DATA_DIR/$FOLDER_NAME"

# --- Install AutoKey if not present ---
if ! command -v autokey-gtk &>/dev/null; then
    echo "Installing autokey-gtk..."
    sudo apt update
    sudo apt install -y autokey-gtk
    echo "autokey-gtk installed."
else
    echo "autokey-gtk is already installed."
fi

# --- Create the data directory if needed ---
mkdir -p "$AUTOKEY_DATA_DIR"

# --- Create the folder for "Common AI Prompts" ---
mkdir -p "$FOLDER_DIR"

# Folder metadata (.folder)
cat > "$FOLDER_DIR/.folder.json" <<'FOLDERJSON'
{
    "usageCount": 0,
    "abbreviation": {
        "abbreviations": [],
        "backspace": true,
        "ignoreCase": false,
        "immediate": false,
        "triggerInside": false,
        "wordChars": "[\\w]"
    },
    "hotkey": {
        "modifiers": ["<ctrl>", "<shift>"],
        "hotKey": "m",
        "enabled": true
    },
    "modes": [],
    "showInTrayMenu": true,
    "title": "Common AI Prompts",
    "type": "folder"
}
FOLDERJSON

echo "Created folder: $FOLDER_NAME (hotkey: Ctrl+Shift+M)"

# --- Helper function to create a phrase ---
create_phrase() {
    local filename="$1"
    local title="$2"
    local text="$3"

    # Write the phrase text
    cat > "$FOLDER_DIR/$filename.txt" <<PHRASETXT
$text
PHRASETXT

    # Write the phrase metadata
    cat > "$FOLDER_DIR/.$filename.json" <<PHRASEJSON
{
    "usageCount": 0,
    "omitTrigger": false,
    "prompt": false,
    "description": "$title",
    "abbreviation": {
        "abbreviations": [],
        "backspace": true,
        "ignoreCase": false,
        "immediate": false,
        "triggerInside": false,
        "wordChars": "[\\w]"
    },
    "hotkey": {
        "modifiers": [],
        "hotKey": null,
        "enabled": false
    },
    "modes": [],
    "showInTrayMenu": false,
    "matchCase": false,
    "filter": {
        "regex": null,
        "isRecursive": false
    },
    "type": "phrase",
    "sendMode": "clipboard"
}
PHRASEJSON

    echo "  Added phrase: $title"
}

# --- Create phrases ---
echo "Adding phrases..."

create_phrase "save-for-claude-restart" \
    "Save for Claude Restart" \
    "Please save everything to memory, so I can stop Claude code and then restart from exactly the same place."

create_phrase "summarize-this-code" \
    "Summarize This Code" \
    "Please provide a brief summary of what this code does, its inputs, outputs, and any important side effects."

create_phrase "find-bugs" \
    "Find Bugs in This Code" \
    "Please review this code for bugs, edge cases, and potential issues. List each issue with its severity and a suggested fix."

create_phrase "write-tests" \
    "Write Tests for This" \
    "Please write comprehensive tests for this code, covering normal cases, edge cases, and error conditions."

create_phrase "explain-error" \
    "Explain This Error" \
    "Please explain what this error means, what likely caused it, and how to fix it."

# --- Done ---
echo ""
echo "========================================="
echo "  Setup complete!"
echo "========================================="
echo ""
echo "Usage:"
echo "  1. Start AutoKey:  autokey-gtk &"
echo "  2. Press Ctrl+Shift+M anywhere to open the 'Common AI Prompts' menu"
echo "  3. Select a phrase to paste it at your cursor"
echo ""
echo "To auto-start AutoKey on login:"
echo "  Open 'Startup Applications' and add: autokey-gtk"
echo ""
echo "To add more phrases, either:"
echo "  - Use the AutoKey GUI"
echo "  - Re-run this script after adding more create_phrase calls"
echo "  - Manually add .txt + .json files in: $FOLDER_DIR"
