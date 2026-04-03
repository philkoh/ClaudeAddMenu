---
name: AI Prompts Menu - Cross-Platform
description: Ctrl+Shift+M popup menu to insert AI prompt text at cursor - works on Linux desktop, SSH+tmux, and Windows
type: project
---

## Status: WORKING (Linux desktop), UNTESTED (tmux, Windows)

## What It Does
Press **Ctrl+Shift+M** (or tmux prefix+m) → popup menu appears → select a prompt → text is inserted at cursor.

## Architecture
- `prompts.json` — single source of truth for all prompts (JSON array of {label, text})
- `ai-prompts-menu.sh` — Linux desktop launcher (rofi + ydotool + jq)
- `tmux-prompts.sh` — SSH+tmux launcher (fzf + tmux paste-buffer + jq)
- `ai-prompts-menu.ahk` — Windows launcher (AutoHotkey v2, Ctrl+Shift+M)

## System Config (Linux Desktop)
1. `/etc/sudoers.d/ydotool-phil` — passwordless sudo for ydotool
2. `/etc/udev/rules.d/80-uinput.rules` — gives `input` group access to `/dev/uinput`
3. GNOME custom shortcut `custom0` → Ctrl+Shift+M → runs ai-prompts-menu.sh

## Key Lessons
- `wtype` does NOT work on GNOME Wayland (no virtual keyboard protocol)
- `xdotool` does NOT work for native Wayland apps
- `ydotool type --file` is the reliable approach on v0.1.8
- rofi requires `-me-select-entry '' -me-accept-entry 'MousePrimary'` for single-click
- Ctrl+Shift+M doesn't pass through SSH terminals reliably — use tmux bind-key instead

**Why:** User wants quick keyboard-triggered access to common AI prompts on all platforms.
**How to apply:** To add/edit prompts, edit `prompts.json`. All launchers read from it automatically.
