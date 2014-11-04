
# Initialize bash_completion
# Without homebrew, this will source /etc/bash_completion
if [ -f $BREW_PREFIX/etc/bash_completion ]; then
  . $BREW_PREFIX/etc/bash_completion
fi

if $IS_OSX; then
  complete -W "NSGlobalDomain" defaults
fi
