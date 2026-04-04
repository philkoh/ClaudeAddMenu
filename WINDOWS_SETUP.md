# Windows Git Auth Setup

This file contains instructions for Claude Code to fix git push authentication on Windows.

## Prerequisites
- `GITHUB_TOKEN` environment variable must be set before starting Claude Code
- You must be in the ClaudeAddMenu repo directory

## Steps

1. **Switch remote to HTTPS with token auth:**
   ```
   git remote set-url origin https://x-access-token:%GITHUB_TOKEN%@github.com/philkoh/ClaudeAddMenu.git
   ```
   Note: On Windows, use `%GITHUB_TOKEN%` in cmd or `$env:GITHUB_TOKEN` in PowerShell. In practice, Claude Code's shell should expand `${GITHUB_TOKEN}` automatically.

2. **Verify it works:**
   ```
   git push --dry-run
   ```

3. **Pull latest changes:**
   ```
   git pull origin main
   ```

4. **Confirm status is clean and up to date:**
   ```
   git status
   ```

That's it. The repo should now be able to push and pull on this machine.
