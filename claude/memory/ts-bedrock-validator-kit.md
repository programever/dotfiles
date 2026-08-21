---
name: ts-bedrock-validator-kit
description: Two-gate review kit at ~/Workspace/ts-bedrock-validator (from Steven's 2026-08-19 handoff); fully working since 2026-08-21.
metadata:
  type: project
---

On 2026-08-21 Alpha set up Steven's validator kit at `~/Workspace/ts-bedrock-validator/` (bin/validate-mech.sh, bin/validate.sh, prompt.md, rubric-ts-bedrock.md, verdicts/). Protocol lives in the Workspace CLAUDE.md (dotfiles/claude/CLAUDE-Alpha.md). Fixes vs the handoff doc: kit path is `~/Workspace/ts-bedrock-validator` (not hidden), default model `claude-fable-5` (builder is Fable 5), `bedrock-exempt` lines skip Gate 1 scans, Gate 2 runs tsc+lint separately (check only as fallback), validate.sh auto-finds the desktop-app CLI bundle.

**Why:** Gate 1 dry run passed on ts-bedrock. Gate 2 dry run reached the CLI but it reported "Not logged in" — the desktop app's auth is not shared with the standalone `claude -p` binary.
On 2026-08-21 the standalone CLI was installed with `brew install --cask claude-code` (/opt/homebrew/bin/claude) and the step added to dotfiles/Setup.md.
**How to apply:** Before relying on Gate 2, confirm `claude auth status` shows loggedIn true; if not, Iker must log in once (I cannot do logins). Re-run the Gate 2 dry run after that. Related: [[call-me-alpha]].
