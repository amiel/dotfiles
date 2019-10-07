

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# if __command_exists yarn; then
#   export PATH="`yarn global bin`:$PATH"
# fi

if [ -e ~/.nmprc ];then
  export NPM_AUTH_TOKEN="$(head -n 1 ~/.npmrc | sed "s/\/\/.*=//")"
fi

export NODE_PATH="$BREW_PREFIX/lib/node:$BREW_PREFIX/lib/node_modules"
export PATH="$PATH:/usr/local/share/npm/bin"

