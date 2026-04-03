---
name: Auto-commit standing order
description: Always commit, push, and save to memory after successfully adding a new feature — do this autonomously
type: feedback
---

Always commit, push, and save to memory whenever a new feature is successfully added. Do this autonomously without being asked.

- Commit after successful tests; avoid committing when in a broken state.
- Push using the deploy key with IdentitiesOnly=yes.
- The user may delete the directory and re-clone, so all important files must be tracked in git.
- Memory files in `.claude-memory/` in the repo should stay in sync with the Claude Code memory system.

**Why:** User wants continuous backup to GitHub and wants to be able to resume work after re-cloning.
**How to apply:** After completing any feature or fix, stage changes, commit with a descriptive message, and push. Also update memory files if project state changed.
