
# Initialize bash_completion
# Without homebrew, this will source /etc/bash_completion
if [ -f $BREW_PREFIX/etc/bash_completion ]; then
  . $BREW_PREFIX/etc/bash_completion
fi

if $IS_OSX; then
  complete -W "NSGlobalDomain" defaults
fi

_fzf_compgen_path() {
  ag -g "" "$1"
}

export FZF_DEFAULT_COMMAND='ag -g ""'
source "$HOME/.config/base16-fzf/bash/base16-material-darker.config"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --reverse --inline-info"
