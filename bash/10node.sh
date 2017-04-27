export NVM_DIR="$HOME/.nvm"

if __command_exists brew; then
  . "$(brew --prefix nvm)/nvm.sh"
fi

if __command_exists yarn; then
  export PATH="`yarn global bin`:$PATH"
fi

export NPM_AUTH_TOKEN="$(head -n 1 ~/.npmrc | sed "s/\/\/.*=//")"
