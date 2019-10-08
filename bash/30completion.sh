
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

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=/Users/amiel/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;

###-tns-completion-start-###
if [ -f /Users/amiel/.tnsrc ]; then
    source /Users/amiel/.tnsrc
fi
###-tns-completion-end-###


