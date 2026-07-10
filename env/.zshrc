# Powerlevel10k instant prompt. Keep at the very top of the file.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/personal/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh My Zsh (also runs compinit)
source "$ZSH/oh-my-zsh.sh"

# Powerlevel10k config
[[ -f "$HOME/personal/.p10k.zsh" ]] && source "$HOME/personal/.p10k.zsh"

[[ -d "$HOME/personal/zsh-autosuggestions" ]] && source "$HOME/personal/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Personal profile
[[ -f "$HOME/personal/.zsh_profile" ]] && source "$HOME/personal/.zsh_profile"
