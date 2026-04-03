---
name: GitHub repo and deploy key
description: ClaudeAddMenu repo at philkoh/ClaudeAddMenu, deploy key in project dir, push requires IdentitiesOnly=yes
type: reference
---

- Repo: `philkoh/ClaudeAddMenu` (public)
- Remote: `git@github.com:philkoh/ClaudeAddMenu.git` (SSH)
- Deploy key: `/home/phil/ClaudeAddMenu/deploy_key` (private, gitignored), `deploy_key.pub` (tracked)
- Push: `git push` (core.sshCommand configured in repo's git config to use deploy key with IdentitiesOnly=yes)
- The `IdentitiesOnly=yes` flag is required because the SSH agent has other keys that would otherwise match first.
- Git identity: Phil Koh <pk14225@gmail.com> (configured per-repo, not global)
