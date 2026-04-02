# ClaudeAddMenu Memory

## Project Overview
Cross-platform AI prompts popup menu. Ctrl+Shift+M opens a menu, select a prompt to type it at cursor.

## Platforms Configured
- **Linux Desktop (Wayland/GNOME)** — rofi + ydotool, configured on Phil's Ubuntu
- **SSH + tmux** — fzf + tmux paste-buffer, prefix+m
- **Windows PCs** — AutoHotkey v2, Ctrl+Shift+M
  - Auth via GITHUB_TOKEN env var (HTTPS remote URL)
  - AHK startup shortcut in shell:startup folder

## Key Architecture
- `prompts.json` is the single source of truth for all platforms
- Each platform has its own launcher script reading from prompts.json

## Authentication
- **Windows:** GITHUB_TOKEN env var embedded in HTTPS remote URL
- **Linux:** SSH deploy key at `deploy_key` (gitignored), `deploy_key.pub` tracked

## User
- Phil Koh, pk14225@gmail.com
- Prefers keyboard-driven tools
- Standing order: always commit, push, and save to memory on successful new features

## See Also
- [CLAUDE.md](../../CLAUDE.md) for full project docs
