export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"

export NPM_AUTH_TOKEN="$(head -n 1 ~/.npmrc | sed "s/\/\/.*=//")"
