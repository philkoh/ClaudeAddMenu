---
name: GitHub repo and authentication
description: ClaudeAddMenu repo at philkoh/ClaudeAddMenu, uses GITHUB_TOKEN on Windows, deploy key on Linux
type: reference
---

- Repo: `philkoh/ClaudeAddMenu` (public)
- Windows remote: `https://x-access-token:${GITHUB_TOKEN}@github.com/philkoh/ClaudeAddMenu.git` (HTTPS with token)
- Linux remote: `git@github.com:philkoh/ClaudeAddMenu.git` (SSH with deploy key)
- Deploy key (Linux): `/home/phil/ClaudeAddMenu/deploy_key` (private, gitignored), `deploy_key.pub` (tracked)
- Linux push: `GIT_SSH_COMMAND="ssh -i /home/phil/ClaudeAddMenu/deploy_key -o IdentitiesOnly=yes" git push`
- Windows push: `git push` (GITHUB_TOKEN embedded in remote URL)
- Git identity: Phil Koh <pk14225@gmail.com> (configured per-repo, not global)
