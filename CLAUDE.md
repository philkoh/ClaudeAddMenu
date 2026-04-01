# ClaudeAddMenu

Cross-platform AI prompts popup menu. Press **Ctrl+Shift+M** to open a menu, select a prompt to type it at the cursor.

## Standing Orders

- **Always commit, push, and save to memory whenever a new feature is successfully added.** Do this autonomously without being asked.
- Try to commit after successful tests; avoid committing when in a broken state.
- The user may delete this directory and re-clone from GitHub, so ensure all important files are tracked.
- Memory files in `.claude-memory/` should be kept in sync with the Claude Code memory system at `~/.claude/projects/-home-phil-ClaudeAddMenu/memory/`.

## Key Files

- `prompts.json` — Shared prompt definitions (single source of truth for all platforms)
- `ai-prompts-menu.sh` — Linux desktop launcher (rofi + ydotool, Wayland)
- `tmux-prompts.sh` — SSH+tmux launcher (fzf + tmux paste-buffer)
- `ai-prompts-menu.ahk` — Windows launcher (AutoHotkey v2)
- `setup-autokey-prompts.sh` — Legacy AutoKey setup (doesn't work on Wayland, kept for reference)
- `deploy_key.pub` — Deploy key public half (private key in `deploy_key`, gitignored)

## Platform Setup

### Linux Desktop (Wayland/GNOME)
- Dependencies: `rofi`, `ydotool`, `jq`, `wl-clipboard`
- Passwordless sudo for ydotool: `/etc/sudoers.d/ydotool-phil`
- udev rule for uinput: `/etc/udev/rules.d/80-uinput.rules`
- GNOME custom shortcut `custom0` → Ctrl+Shift+M → `ai-prompts-menu.sh`

### SSH + tmux
- Dependencies: `jq`, `fzf`
- Add to `~/.tmux.conf`: `bind-key m run-shell "/path/to/ClaudeAddMenu/tmux-prompts.sh"`
- Trigger with: `prefix + m` (Ctrl+Shift+M doesn't pass through terminals reliably)

### Windows
- Install AutoHotkey v2 from https://www.autohotkey.com/
- Double-click `ai-prompts-menu.ahk` to run, or add to shell:startup
- Ctrl+Shift+M works natively

## Adding/Editing Prompts

Edit `prompts.json`: it's a JSON array of `{"label": "...", "text": "..."}` objects. Display order matches array order. All platform launchers read from this single file.

## User Context

- Phil runs Ubuntu with GNOME Shell 46.0 on Wayland
- Also uses Ubuntu VMs via SSH+tmux and Windows desktop PCs
- Prefers keyboard-driven productivity tools
- Always verify system state before proposing solutions (don't assume X11 vs Wayland, etc.)
