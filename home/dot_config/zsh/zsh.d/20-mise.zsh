if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
  mise_shims="${XDG_DATA_HOME:-$HOME/.local/share}/mise/shims"
  case ":$PATH:" in
    *":$mise_shims:"*) ;;
    *) export PATH="$mise_shims:$PATH" ;;
  esac
  unset mise_shims
fi