---
name: AI Prompts Menu - Complete
description: Ctrl+Shift+M popup menu to insert AI prompt text at cursor on Ubuntu GNOME Wayland - working
type: project
---

## Status: WORKING

## What It Does
Press **Ctrl+Shift+M** anywhere → rofi popup menu appears → single-click a prompt → text is typed at cursor.

## Implementation
- Script: `/home/phil/ClaudeAddMenu/ai-prompts-menu.sh`
- Uses **rofi** for menu display (with `-me-select-entry '' -me-accept-entry 'MousePrimary'` for single-click)
- Uses **sudo ydotool type --file** to type text at cursor via kernel uinput
- GNOME custom keyboard shortcut bound to Ctrl+Shift+M

## System Config Changes Made
1. Installed: `autokey-gtk` (unused, was first attempt), `wtype` (unused, doesn't work on GNOME), `xdotool` (unused), `ydotool`, `wl-clipboard`
2. `/etc/sudoers.d/ydotool-phil` — passwordless sudo for ydotool
3. `/etc/udev/rules.d/80-uinput.rules` — gives `input` group access to `/dev/uinput`
4. User `phil` added to `input` group (after re-login, ydotool won't need sudo)
5. GNOME custom shortcut `custom0` → Ctrl+Shift+M → runs the script
6. AutoKey config in `~/.config/autokey/data/Common AI Prompts/` (unused, doesn't work on Wayland)

## Current Prompts
- Save for Claude Restart
- Summarize This Code
- Find Bugs in This Code
- Write Tests for This
- Explain This Error

## Key Lessons
- `wtype` does NOT work on GNOME Wayland (no virtual keyboard protocol)
- `xdotool` does NOT work for native Wayland apps
- `ydotool key` v0.1.8 colon syntax (29:1 47:1) is broken — produced "2442"
- `ydotool key ctrl+v` appeared to do nothing
- `ydotool type --file` is the reliable approach on v0.1.8
- rofi requires `-me-select-entry '' -me-accept-entry 'MousePrimary'` for single-click

**Why:** User wants quick keyboard-triggered access to common AI prompts.
**How to apply:** To add new prompts, edit the script — add to both `PROMPTS` array and `OPTIONS` list.
