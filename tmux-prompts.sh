#!/bin/bash
# AI prompts menu for SSH+tmux sessions
# Uses fzf for menu selection, tmux paste-buffer for text insertion
# Reads prompts from shared prompts.json
#
# Setup: add to ~/.tmux.conf:
#   bind-key m run-shell "/path/to/ClaudeAddMenu/tmux-prompts.sh"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROMPTS_FILE="$SCRIPT_DIR/prompts.json"

if [ ! -f "$PROMPTS_FILE" ]; then
    tmux display-message "prompts.json not found"
    exit 1
fi

# Check dependencies
for cmd in jq fzf; do
    if ! command -v "$cmd" &>/dev/null; then
        tmux display-message "$cmd is required but not installed"
        exit 1
    fi
done

# Use tmux popup if available (tmux 3.2+), otherwise split-pane
TMUX_VERSION=$(tmux -V | grep -oP '[\d.]+')

CHOICE=$(jq -r '.[].label' "$PROMPTS_FILE" | \
    fzf --prompt="AI Prompts> " --height=~50% --reverse --no-info)

[ -z "$CHOICE" ] && exit 0

PROMPT_TEXT=$(jq -r --arg label "$CHOICE" '.[] | select(.label == $label) | .text' "$PROMPTS_FILE")
[ -z "$PROMPT_TEXT" ] && exit 0

# Load into tmux paste buffer and paste into the active pane
tmux set-buffer "$PROMPT_TEXT"
tmux paste-buffer
