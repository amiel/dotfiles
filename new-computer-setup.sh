#!/bin/bash


# First:
# 1. Update OSX
# 2. Install XCode
# 3. Copy ssh-keys (`scp x.x.x.x:'.ssh/id_rsa*' .ssh/`)
# 4. Install dropbox and wait for it to sync
# 5. Then, run this script


# Manual settings (TODO: script them)
#
# * Setup dvorak
# * ctrl-option-command swicches input sources
# * set up bluetooth keyboard and trackpad
# * keyboard: capslock -> control
# * trackpad speed
#
# * 1password
# * Alfred license from 1password

# Ask for the administrator password upfront
sudo -v

###############
# OSX Settings

#######################
# Application Settings

# Set Alfred sync folder
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder -string ~/Dropbox/Preferences

# Set iterm2 sync folder
defaults write com.googlecode.iterm2 PrefsCustomFolder -string ~/Dropbox/Preferences

######################
# Set up a few things

[ -d ~/src ] || mkdir ~/src
[ -e ~/src/dotfiles ] || ln -s ~/Dropbox/dotfiles ~/src/dotfiles
~/src/dotfiles/bin/link-dotfiles

###########
# Homebrew

# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew bundle install



# fonts from https://github.com/romkatv/powerlevel10k#installation
