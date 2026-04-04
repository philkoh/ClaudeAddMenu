---
name: GitHub repo and authentication
description: ClaudeAddMenu repo at philkoh/ClaudeAddMenu, all machines use SSH deploy keys
type: reference
---

- Repo: `philkoh/ClaudeAddMenu` (public)
- All machines use SSH remote: `git@github.com:philkoh/ClaudeAddMenu.git`
- Each machine has its own deploy key pair (`deploy_key` private/gitignored, `deploy_key.pub` tracked)
- SSH configured via `core.sshCommand` per-repo: `ssh -i <path>/deploy_key -o IdentitiesOnly=yes`
- Deploy keys on GitHub: Linux (ClaudeAddMenu-deploy-v2), Tiny (deploy-ClaudeAddMenu-Tiny), AIwin (deploy-ClaudeAddMenu-AIwin)
- GITHUB_TOKEN env var available on Windows for API calls (adding deploy keys, etc.)
- Git identity: Phil Koh <pk14225@gmail.com> (configured per-repo, not global)
