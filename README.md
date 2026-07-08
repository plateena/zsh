# Zsh Configuration

Custom zsh setup with vi mode, fzf integration, and tmux alignment.

## Prerequisites

- zsh
- [fzf](https://github.com/junegunn/fzf)
- [fd](https://github.com/sharkdp/fd) (fzf file search)
- [atuin](https://github.com/atuinsh/atuin) (shell history)
- [eza](https://github.com/eza-community/eza) (ls replacement)
- [bat](https://github.com/sharkdp/bat) (cat replacement)
- [zoxide](https://github.com/ajeetdsouza/zoxide) (cd replacement)
- [wl-copy](https://github.com/bugaevc/wl-clipboard) (Wayland clipboard)
- Nerd Font (icons in prompt)
- tmux (optional, but config is aligned with it)

## Setup

```bash
# Set ZDOTDIR in /etc/zsh/zshenv or ~/.zshenv
export ZDOTDIR="$HOME/.config/zsh"
```

Tmux sets `default-shell /usr/bin/zsh` and picks up the config via ZDOTDIR.

## File Structure

```
.zshrc              Entry point, sources everything
.zprofile           Login shell setup (kiro hooks only)
env.zsh             Environment variables, PATH, lazy-loaded tools
keybind.zsh         Vi mode keybindings
keybind/fzf.zsh     Fzf key bindings (Ctrl+T, Alt+C, Ctrl+F)
fzf.zsh             Fzf configuration (commands, preview, options)
prompt.zsh          Left/right prompt with git info
plugins.zsh         Plugin loading (fzf-tab, autosuggestions, syntax-highlighting)
alias.zsh           Expandable aliases (space to expand)
utils/plug.zsh      Minimal plugin manager
completions/        Custom completion functions
bin/                Helper scripts (welcome, shortendir)
plugin_config/      Per-plugin config (fzf-tab)
plugins/            Cloned plugin repos
```

## Vi Mode

Uses `bindkey -v` with these bindings:

| Key | Mode | Action |
|-----|------|--------|
| `jk` | viins | Escape to normal mode |
| `v` | vicmd | Edit line in nvim |
| `Alt+Y` | both | Copy command to clipboard |
| `Alt+L` | viins | Accept autosuggestion |
| `Alt+F` | viins | Forward one word |
| `Alt+R` | both | Atuin session search (current pane) |

Cursor shape changes automatically: beam in insert, block in normal.

`KEYTIMEOUT=20` (200ms for multi-key sequences like `jk`).

## History

Atuin handles search and sync. File-based history is fallback only.

- `Ctrl+R` - atuin search (global)
- `Alt+R` - atuin session search (current tmux pane)
- `k` in vicmd - atuin up-search (contextual)

## Fzf Integration

| Key | Action |
|-----|--------|
| `Ctrl+T` | File picker (fd) |
| `Alt+C` | Directory picker (cd into) |
| `Ctrl+F` | History search (fzf, not atuin) |
| `Ctrl+D` | Switch fzf to directories mode |
| `Ctrl+F` (in fzf) | Switch to files mode |
| `Ctrl+S` (in fzf) | Switch to all mode |
| `Ctrl+Y` (in fzf) | Copy path to clipboard |
| `?` or `Ctrl+/` | Toggle preview |

Tab completion uses fzf-tab (fuzzy matching in completions).

## Aliases

Aliases auto-expand on space. Type the alias then press space to see the full command before running.

Categories: git, docker, tmux, npm, taskwarrior, timewarrior, system.

Use `al` to fuzzy-search all aliases.

## Tmux Alignment

- OSC 7 reports CWD on every `cd` so tmux `#{pane_current_path}` is always accurate
- Cursor shape escapes pass through tmux (configured in tmux.conf terminal-overrides)
- Clipboard uses `wl-copy` in both zsh and tmux copy-mode
- Vi mode keys consistent: zsh vi mode + tmux `mode-keys vi`
- `add-zsh-hook` used for precmd/preexec to avoid conflicts with tmux plugins

## Plugins

Loaded via minimal `plug.zsh` (clone-on-first-use):

- **fzf-tab** - fuzzy tab completion
- **zsh-syntax-highlighting** - command highlighting
- **zsh-autosuggestions** - fish-like suggestions
- **zsh-completions** - extra completion definitions
- **alias-tips** - reminds you of available aliases

## Lazy Loading

These tools load on first use (faster shell startup):

- nvm (node/npm/npx)
- pyenv
- rbenv

## Adding a New Plugin

```bash
# In plugins.zsh, add:
plug "author/plugin-name"
```

Plugin gets cloned to `plugins/author/plugin-name` on next shell start.

## Troubleshooting

- **Cursor stuck as block**: Run `echo -ne '\e[5 q'` or open new shell
- **Completions stale**: Delete `.zcompdump` and restart shell
- **Atuin overrides keys**: Atuin init runs last, check `atuin init zsh | grep bindkey`
- **Icons misaligned**: Don't use `%G` on prompt icons unless they render as zero-width
- **Slow startup**: Check which lazy-load wrapper is triggering early (`nvm`, `rbenv`, `pyenv`)
