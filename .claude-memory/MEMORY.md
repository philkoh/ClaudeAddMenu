# ClaudeAddMenu Memory

## Project Overview
Cross-platform AI prompts popup menu. Ctrl+Shift+M opens a menu, select a prompt to type it at cursor.

## Platforms Configured
- **Linux Desktop (Wayland/GNOME)** — rofi + ydotool, configured on Phil's Ubuntu
- **SSH + tmux** — fzf + tmux paste-buffer, prefix+m
- **Windows (this PC)** — AutoHotkey v2, set up on pk142's Windows 11 PC
  - AHK v2.0.21 installed at: `C:\Users\pk142\AppData\Local\Programs\AutoHotkey`
  - Startup shortcut created in shell:startup folder
  - Repo cloned to `C:\ClaudeAddMenu`

## Key Architecture
- `prompts.json` is the single source of truth for all platforms
- Each platform has its own launcher script reading from prompts.json

## User
- Phil Koh, pk14225@gmail.com
- Prefers keyboard-driven tools
- Standing order: always commit, push, and save to memory on successful new features

## Pending Task: Set up deploy key for GitHub push
- The repo has a `deploy_key.pub` (ed25519) tracked in git
- The private key (`deploy_key`) is gitignored and does NOT exist on this Windows PC yet
- Need to either:
  1. Generate a new deploy key pair on this machine, add the public key to GitHub repo settings, OR
  2. Copy the existing private key from the Linux machine
- The remote URL needs to be checked/set to SSH (git@github.com:...) for deploy key auth
- Configure SSH to use the deploy key for github.com (via `~/.ssh/config` or `GIT_SSH_COMMAND`)

## Session State
- Windows setup is DONE: AHK script running, startup shortcut created
- Git working tree is clean, branch `main` is up to date with origin
- Deploy key setup was started but not completed — pick up from here

## See Also
- [CLAUDE.md](../../CLAUDE.md) for full project docs
