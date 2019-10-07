
export LC_ALL='en_US.UTF-8'
export LC_CTYPE='en_US.UTF-8'
export LANG='en_US.UTF-8'
export PAGER='less'

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

if $IS_OSX; then
  export BREW_PREFIX=`brew --prefix`

  export MANPATH="$BREW_PREFIX/share/man:$MANPATH"

  export EDITOR="nvim"
else
  export EDITOR=vi
fi

export GPG_TTY=$(tty)

# Report the status of terminated background jobs immediately, rather than before the next
# primary prompt.  This is effective only when job control is enabled.
set -o notify

# Make sure terminals wrap lines correctly after resizing them.
shopt -s checkwinsize

# Ensure that command history is saved for all terminals.
# https://twitter.com/#!/bashtips/status/2908837032
shopt -s histappend
export PROMPT_COMMAND='history -a'

# Options: ignorespace, ignoredups
#   ignoredups:   does not record duplicate history items
#   ignorespace:  does not record with leading space to history
export HISTCONTROL=ignoredups

# Fuck that you have new mail shit
unset MAILCHECK

