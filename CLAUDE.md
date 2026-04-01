# ClaudeAddMenu

Wayland-native AI prompts popup menu. Press **Ctrl+Shift+M** anywhere to open a rofi menu, single-click a prompt to type it at cursor via ydotool.

## Standing Orders

- **Always commit, push, and save to memory whenever a new feature is successfully added.** Do this autonomously without being asked.
- Try to commit after successful tests; avoid committing when in a broken state.
- The user may delete this directory and re-clone from GitHub, so ensure all important files are tracked.
- Memory files in `.claude-memory/` should be kept in sync with the Claude Code memory system at `~/.claude/projects/-home-phil-ClaudeAddMenu/memory/`.

## Key Files

- `ai-prompts-menu.sh` — Main menu script (rofi + ydotool)
- `setup-autokey-prompts.sh` — Legacy AutoKey setup (doesn't work on Wayland, kept for reference)
- `deploy_key.pub` — Deploy key public half (private key in `deploy_key`, gitignored)

## System Dependencies

- `rofi` — menu display
- `ydotool` — types text at cursor via kernel uinput
- `wl-clipboard` — clipboard access
- Passwordless sudo for ydotool: `/etc/sudoers.d/ydotool-phil`
- udev rule for uinput: `/etc/udev/rules.d/80-uinput.rules`
- GNOME custom shortcut `custom0` → Ctrl+Shift+M

## Adding Prompts

Edit `ai-prompts-menu.sh`: add entry to both the `PROMPTS` associative array and the `OPTIONS` variable.

## User Context

- Phil runs Ubuntu with GNOME Shell 46.0 on Wayland
- Prefers keyboard-driven productivity tools
- Always verify system state before proposing solutions (don't assume X11 vs Wayland, etc.)
