# Roaixon

Minimal development environment for terminal. Inspired by [ThePrimeagen](https://github.com/ThePrimeagen/dev).

## Quick Start

```bash
# macOS
./run --mac

# Linux  
./run --linux

# Dry run (preview)
./run --mac --dry
```

## What's Installed

- **Neovim** - with LSP, Treesitter, Telescope, and minimal plugins
- **tmux** - with resurrect for session persistence
- **zsh** - with Oh My Zsh and Powerlevel10k
- **fzf** - fuzzy finder
- **ripgrep** - fast search
- **fd** - fast find

## Neovim LSP Support

- Python (pyright)
- TypeScript/JavaScript (ts_ls)
- Bash (bashls)
- Docker/docker-compose
- JSON, TOML, YAML
- Lua

## Key Bindings

### Neovim

| Key | Action |
|-----|--------|
| `<Space>` | Leader |
| `-` | Open file explorer (oil) |
| `<leader>fd` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover docs |
| `<leader>ca` | Code actions |
| `<leader>f` | Format |
| `<leader>s` | Search & replace word |

### tmux

| Key | Action |
|-----|--------|
| `Ctrl-a` | Prefix (instead of Ctrl-b) |
| `Prefix + "` | Split horizontal |
| `Prefix + %` | Split vertical |
| `Prefix + h/j/k/l` | Navigate panes |

## Structure

```
roaixon/
├── run                 # Main installer
├── runs/               # Install scripts (executed in order)
│   ├── 10-fonts
│   ├── 20-zsh
│   ├── 30-libs
│   ├── 40-tmux
│   └── 50-neovim
└── env/                # Config files
    ├── .config/
    │   ├── nvim/
    │   ├── tmux/
    │   └── personal/
    ├── .zshrc
    ├── .zsh_profile
    └── .p10k.zsh
```

## After Install

```bash
source "$HOME/personal/.zshrc"
```

Then in tmux, press `Prefix + I` to install plugins.
