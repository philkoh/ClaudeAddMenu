---
name: Deploy Key Auth — Resolved, Per-Machine Model
description: Settled on per-machine deploy keys for repo auth; AddMenuPlan.md has setup instructions for new machines
type: project
---

## Auth Model: Per-Machine Deploy Keys (decided 2026-04-04)

After evaluating options (shared deploy key, GITHUB_TOKEN, fine-grained PATs, gh auth), settled on **one deploy key per machine**:
- Each machine generates its own key pair
- Each public key added to GitHub as a deploy key with read-write access
- Private key never leaves the machine
- `core.sshCommand` configured in repo git config (no GIT_SSH_COMMAND needed)

### Current state:
- **Linux desktop**: Working. Deploy key configured, `core.sshCommand` set, pushes work.
- **Windows PC**: Not yet set up. User needs to run Claude there with prompt: `Read AddMenuPlan.md and follow the "Setting up a new machine" instructions.`
- **AddMenuPlan.md**: Pushed to repo. Contains full project docs + new machine setup instructions.

**Why:** Deploy keys scope access to one repo (more secure than PATs/gh auth). Per-machine keys avoid the shared-secret distribution problem.
**How to apply:** For any new machine, point Claude at AddMenuPlan.md. Don't suggest PATs or shared keys.
