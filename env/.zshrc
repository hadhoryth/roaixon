# Powerlevel10k instant prompt. Keep at the very top of the file.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/personal/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Disable Oh My Zsh's self-update: its update check/prompt writes to the
# console during startup, which breaks Powerlevel10k's instant prompt.
# Versions are managed by the setup script (runs/30-zsh), not by OMZ itself.
zstyle ':omz:update' mode disabled

# Oh My Zsh (also runs compinit)
source "$ZSH/oh-my-zsh.sh"

# Powerlevel10k config
[[ -f "$HOME/personal/.p10k.zsh" ]] && source "$HOME/personal/.p10k.zsh"

[[ -d "$HOME/personal/zsh-autosuggestions" ]] && source "$HOME/personal/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Personal profile
[[ -f "$HOME/personal/.zsh_profile" ]] && source "$HOME/personal/.zsh_profile"
