---
name: Deploy Key Fix Resolved
description: Deploy key mismatch from multi-machine use has been fixed; core.sshCommand configured
type: project
---

## Deploy Key — RESOLVED (2026-04-03)

The deploy key private/public pair was out of sync due to multi-machine clones. Fixed by:
1. Updated `deploy_key.pub` to match current private key
2. Removed stale GitHub deploy key (`deploy-ClaudeAddMenu-Tiny`)
3. Configured `core.sshCommand` in repo git config (no more GIT_SSH_COMMAND needed)
4. Verified SSH push works correctly

**Why:** Deploy key is the primary push credential. Multi-machine use caused key mismatch.
**How to apply:** Just use `git push` — core.sshCommand handles the key selection automatically.
