#!/bin/bash

hash colordiff 2>&- && DIFF=colordiff || DIFF=diff


if [ -f .git/config ];then
  echo "Found .git/config. Replacing https references to github with ssh style"
  ruby -p -i.bak -e'gsub("https://github.com/", "git@github.com:")' .git/config

  echo "Done, here's the diff"
  $DIFF -u .git/config.bak .git/config

  read -p "Is it ok? (y/n) " yn
  if [ $yn == y ];then
    echo "Yes, I thought you would like it. You're good to go"
    rm .git/config.bak
  else
    echo "Sorry it wasn't up to par. I've reverted the change"
    mv .git/config.bak .git/config
  fi
else
  echo "Not a git repo"
fi
