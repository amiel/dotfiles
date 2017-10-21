export NVM_DIR="$HOME/.nvm"

# if __command_exists yarn; then
#   export PATH="`yarn global bin`:$PATH"
# fi

if __command_exists brew; then
  . "$(brew --prefix nvm)/nvm.sh"
fi

if [ -e ~/.nmprc ];then
  export NPM_AUTH_TOKEN="$(head -n 1 ~/.npmrc | sed "s/\/\/.*=//")"
fi
