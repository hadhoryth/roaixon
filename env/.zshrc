ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh My Zsh
source "$HOME/personal/oh-my-zsh/oh-my-zsh.sh"

# Powerlevel10k config
[[ -f "$HOME/personal/.p10k.zsh" ]] && source "$HOME/personal/.p10k.zsh"

# Autocomplete (load before zsh_profile)
[[ -d "$HOME/personal/autocomplete" ]] && source "$HOME/personal/autocomplete/zsh-autocomplete.plugin.zsh"

# Personal profile
[[ -f "$HOME/personal/.zsh_profile" ]] && source "$HOME/personal/.zsh_profile"
