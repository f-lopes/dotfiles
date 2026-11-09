if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

if [[ -r "$HOME/.atuin/bin/env" ]]; then
  source "$HOME/.atuin/bin/env"
fi
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi