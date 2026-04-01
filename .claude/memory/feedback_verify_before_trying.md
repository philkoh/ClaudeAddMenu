---
name: Verify assumptions before suggesting
description: User expects thorough verification of system state before proposing solutions (e.g. X11 vs Wayland mistake)
type: feedback
---

Verify system assumptions before proposing solutions. Don't assume X11 or other defaults — probe the system first.

**Why:** First attempt assumed X11 and wasted time with AutoKey which doesn't work on Wayland.
**How to apply:** Always check `$XDG_SESSION_TYPE`, compositor, and test tools actually work before presenting a solution.
