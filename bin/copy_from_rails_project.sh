#!/bin/bash


rails_directory=$(dirname $1)
rails_file=$(basename $1)

while :; do
  if test -f $rails_directory/config/boot.rb; then
    echo "FOUND"
    break
  fi

  if [ $rails_directory == "/" ]; then
    echo "could not find a nested rails directory"
    exit 1
  fi

  rails_file="$(basename $rails_directory)/$rails_file"
  rails_directory=$(dirname $rails_directory)
done



echo cp -iv $rails_directory/$rails_file $rails_file
cp -iv $rails_directory/$rails_file $rails_file



