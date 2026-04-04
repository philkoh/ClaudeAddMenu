# AddMenuPlan

## What This Is

A cross-platform popup menu for inserting AI prompts at the cursor. Press **Ctrl+Shift+M** → select a prompt → text is typed at the cursor position.

## Menu Prompts

Defined in `prompts.json` — a JSON array of `{"label": "...", "text": "..."}` objects. All platforms read from this single file. Edit it to add, remove, or reorder prompts.

## Platform Launchers

| Platform | Script | Trigger | Dependencies |
|---|---|---|---|
| Linux Desktop (Wayland) | `ai-prompts-menu.sh` | Ctrl+Shift+M (GNOME shortcut) | rofi, ydotool, jq, wl-clipboard |
| SSH + tmux | `tmux-prompts.sh` | tmux prefix + m | jq, fzf |
| Windows | `ai-prompts-menu.ahk` | Ctrl+Shift+M (native) | AutoHotkey v2 |

## Git Authentication

This repo uses a **per-machine SSH deploy key** scoped to only this repository.

### How it works
- Each machine has its own SSH key pair (private key at `deploy_key`, public at `deploy_key.pub`)
- Each machine's public key is added to GitHub as a deploy key with read-write access
- The private key never leaves the machine it was generated on
- `deploy_key` is gitignored; `deploy_key.pub` is tracked (for the current machine)
- Git is configured to use the key via `core.sshCommand`

### Setting up a new machine

1. **Clone the repo** (HTTPS works for read-only clone of a public repo):
   ```
   git clone https://github.com/philkoh/ClaudeAddMenu.git
   cd ClaudeAddMenu
   ```

2. **Generate a deploy key for this machine:**
   ```
   ssh-keygen -t ed25519 -f deploy_key -N "" -C "deploy-ClaudeAddMenu-$(hostname)"
   ```

3. **Add the public key to GitHub** (requires `GITHUB_TOKEN` env var with repo admin scope, or use `gh`):
   ```
   gh repo deploy-key add deploy_key.pub --repo philkoh/ClaudeAddMenu --title "deploy-$(hostname)" -w
   ```
   If `gh` is not available, add it manually at: GitHub repo → Settings → Deploy keys → Add deploy key (check "Allow write access").

4. **Configure git to use the key:**
   ```
   git remote set-url origin git@github.com:philkoh/ClaudeAddMenu.git
   git config core.sshCommand "ssh -i $(pwd)/deploy_key -o IdentitiesOnly=yes"
   git config user.name "Phil Koh"
   git config user.email "pk14225@gmail.com"
   ```

5. **Verify:**
   ```
   git push --dry-run
   ```

### Why IdentitiesOnly=yes?
SSH agents often hold multiple keys. Without this flag, SSH tries other keys first and may authenticate as the wrong repo's deploy key. This flag forces SSH to use only the specified key.

## Standing Orders for Claude Code

- **Always commit, push, and save to memory** after successfully adding a new feature. Do this autonomously.
- Commit after successful tests; avoid committing when broken.
- All important files must be tracked — the user may delete and re-clone at any time.
- Memory files in `.claude-memory/` should stay in sync with the Claude Code memory system.
