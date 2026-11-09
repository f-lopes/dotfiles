export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
plugins=(git docker kubectl)

if [[ -s "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi