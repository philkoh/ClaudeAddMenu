---
name: GitHub repo and deploy key
description: ClaudeAddMenu repo at philkoh/ClaudeAddMenu, deploy key in project dir, push requires IdentitiesOnly=yes
type: reference
---

- Repo: `philkoh/ClaudeAddMenu` (public)
- Remote: `git@github.com:philkoh/ClaudeAddMenu.git` (SSH)
- Deploy key: `/home/phil/ClaudeAddMenu/deploy_key` (private, gitignored), `deploy_key.pub` (tracked)
- Push command: `GIT_SSH_COMMAND="ssh -i /home/phil/ClaudeAddMenu/deploy_key -o IdentitiesOnly=yes" git push`
- The `-o IdentitiesOnly=yes` flag is required because the SSH agent has other keys that would otherwise match first.
- Git identity: Phil Koh <pk14225@gmail.com> (configured per-repo, not global)
