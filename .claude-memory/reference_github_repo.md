---
name: GitHub repo and deploy key
description: ClaudeAddMenu repo at philkoh/ClaudeAddMenu, per-machine deploy keys, core.sshCommand configured
type: reference
---

- Repo: `philkoh/ClaudeAddMenu` (public)
- Remote: `git@github.com:philkoh/ClaudeAddMenu.git` (SSH)
- Auth model: per-machine deploy keys (each machine has its own key pair)
- SSH configured via `core.sshCommand` per-repo: `ssh -i <path>/deploy_key -o IdentitiesOnly=yes`
- Deploy keys on GitHub: Linux (ClaudeAddMenu-deploy-v2), AIwin (deploy-ClaudeAddMenu-AIwin)
- `IdentitiesOnly=yes` is required because the SSH agent has other keys that would otherwise match first.
- GITHUB_TOKEN env var available on Windows for API calls (adding deploy keys, etc.)
- Git identity: Phil Koh <pk14225@gmail.com> (configured per-repo, not global)
- New machine setup: see `AddMenuPlan.md` in repo root
