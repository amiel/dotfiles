#!/bin/bash


# First:
# 1. Update OSX
# 2. Set keyboard layout (I use Dvorak)
# 3. Set Caps Lock -> Control in modifier keys
# 5. Copy ssh-keys (`scp x.x.x.x:'.ssh/id_rsa*' .ssh/`)
# 6. Install dropbox and wait for it to sync
# 7. Then, run this script


# Manual settings (TODO: script them)
#
# * Update network name in Sharing preferences
# * Keyboard -> shortcuts -> Use keyboard navigation to move focus between cotnrols
# * Setup dvorak
# * ctrl-option-command swicches input sources
# * set up bluetooth keyboard and trackpad
# * keyboard: capslock -> control
# * trackpad speed
#
# * sign in to 1password
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

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# TODO: brew bundle install

# TODO: install pomo
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# fonts from https://github.com/romkatv/powerlevel10k#installation
#
# * alfred license
# * gh auth login
