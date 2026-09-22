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

### Updating an existing Neovim installation

Neovim 0.12 requires the `main` branch of nvim-treesitter and tree-sitter CLI
(installed by `runs/50-neovim`). The legacy `master` branch crashes when parsing
Markdown code blocks.

From this repository, apply the Tree-sitter update without reinstalling the other environments:

```bash
./runs/50-neovim
cp env/.config/nvim/lua/plugins/treesitter.lua ~/.config/nvim/lua/plugins/treesitter.lua
cp env/.config/nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json
nvim
```

Run `:Lazy restore nvim-treesitter`, restart Neovim, and allow the parsers to install.
Use `:TSUpdate` after future Tree-sitter plugin updates.

## Keys

| | |
|---|---|
| tmux prefix | `Ctrl-a` |
| nvim leader | `Space` |
| `-` | file explorer (oil) |
| `<leader>fd` / `fg` / `fb` | find files / grep / buffers |
| `gd` / `gr` / `K` | definition / references / hover |
| `<leader>f` | format |
