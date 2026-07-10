# Roaixon

My terminal environment: zsh + Powerlevel10k, tmux, Neovim. One command per new machine.

## Install

```bash
./run             # auto-detects macOS / Linux
./run --dry       # preview without changing anything
```

## After install

```bash
source ~/personal/.zshrc
tmux              # plugins are already installed (prefix+I only after config changes)
nvim              # wait once while plugins and LSP servers install
```

## What you get

zsh (Oh My Zsh, Powerlevel10k, autosuggestions) · tmux (resurrect, catppuccin) · Neovim (lua_ls, clangd, ruff) · fzf · ripgrep · fd · direnv · Nerd Fonts

WezTerm config is included — install WezTerm itself separately.

## Keys

| | |
|---|---|
| tmux prefix | `Ctrl-a` |
| nvim leader | `Space` |
| `-` | file explorer (oil) |
| `<leader>fd` / `fg` / `fb` | find files / grep / buffers |
| `gd` / `gr` / `K` | definition / references / hover |
| `<leader>f` | format |
