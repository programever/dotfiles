# dotfiles

Iker's macOS workstation config. Everything here is **symlinked** into `$HOME` /
`~/.config`, so editing a file in this repo changes the live setup — no build step.

Fresh machine? Follow [Setup.md](Setup.md) top to bottom.

## Layout

| Path | Linked to | What |
|---|---|---|
| `.zshrc`, `antigen.zsh` | `~/.zshrc` | zsh + antigen bundles (vi-mode, autosuggestions, spaceship) |
| `.tmux.conf` | `~/.tmux.conf` | tmux |
| `tmuxinator/` | `~/.config/tmuxinator` | one session YAML per project (`runner start:work` launches the daily set) |
| `init.lua` | `~/.config/nvim/init.lua` | Neovim (Lazy). `~/.config/nvim/lua/alpha/init.lua` links to `~/Workspace/alpha/lua/init.lua` |
| `.gitconfig`, `.gemrc` | `~/.gitconfig`, `~/.gemrc` | git, ruby gems |
| `.gitui-keys.ron`, `.gitui-theme.ron` | `~/.config/gitui/` | gitui keys + theme |
| `ranger/` | `~/.config/ranger` | ranger file manager |
| `snippets/` | — | editor snippets (Elm) |
| `claude/` | see below | Claude Code context + memory |
| `Runnerfile.sh` | — | `runner` tasks: `start:work`, `start:ts-bedrock` |
| `pyenv/`, `Note/` | — | git-ignored: local python venv (pynvim), symlinks into `~/Dropbox/Note` |

## claude/

Context files for Claude Code, one per assistant persona:

- `CLAUDE-Alpha.md` → linked as `~/Workspace/CLAUDE.md`. Alpha is the coding
  assistant for everything under `~/Workspace`; the file holds its rules and a map
  of every project. Other personas go in `CLAUDE-<Name>.md` and get their own link.
- `memory/` → linked as `~/.claude/projects/-Users-iker-Workspace/memory`. Alpha's
  persistent memory (`MEMORY.md` is the index). The link path is derived from the
  Workspace path, so it only works with Workspace at `~/Workspace`.

There is deliberately no `~/.claude/CLAUDE.md`: Claude Code is only used inside
`~/Workspace`, and a global file would load the same content twice.

Secrets (`~/.ssh`, `~/.aws`, `~/.zsh_secrets`) are **not** in this repo — they are
restored from Dropbox, see Setup.md.
