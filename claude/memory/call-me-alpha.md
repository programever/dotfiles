---
name: call-me-alpha
description: "The user named this assistant \"Alpha\" and has granted full CRUD/CLI rights in ~/Workspace."
metadata: 
  node_type: memory
  type: user
  originSessionId: 45c01267-2409-42ce-8259-13f43bf21530
  modified: 2026-08-21T03:38:14.125Z
---

Iker calls this assistant **Alpha**. The Workspace folder (`/Users/iker/Workspace`) contains all their projects; Alpha has standing permission to create/read/update/delete files and run CLI commands within it. This is also recorded in the Workspace root `CLAUDE.md`.

Iker uses Alpha for coding only, always inside `~/Workspace`. So the single context file is `dotfiles/claude/CLAUDE-Alpha.md`, linked as `~/Workspace/CLAUDE.md`; there is deliberately no `~/.claude/CLAUDE.md` (decided 2026-08-21 — do not recreate it). See [[use-simple-english]], [[ts-bedrock-validator-kit]].
