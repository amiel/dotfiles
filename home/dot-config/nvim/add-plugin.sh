#!/bin/bash

# strict mode
set -euo pipefail
IFS=$'\n\t'

plugin=${1:?Usage: $0 plugin-name}
filename="$(basename "$plugin")"

path=~/.config/nvim/lua/plugins
file="$path/$filename.lua"

if [ -e $file ];then
  echo "$file already exists"
  exit 1
fi

echo "adding $plugin to $file"
echo "return { \"$plugin\" }" > $file

