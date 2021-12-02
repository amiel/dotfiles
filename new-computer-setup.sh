#!/bin/bash


# First:
# 1. Update OSX
# 2. Set keyboard layout (I use Dvorak)
# 3. Set Caps Lock -> Control in modifier keys
# 5. Copy ssh-keys (`scp x.x.x.x:'.ssh/id_rsa*' .ssh/`, or use usb key)
# 6. Install homebrew (docs.brew.sh/Installation)
# 7. `brew install dropbox`
# 8. Sign in to dropbox and wait for it to sync
# 9. Then, run this script


# Manual settings (TODO: script them)
#
# * Update network name in Sharing preferences
# * Keyboard -> shortcuts -> Use keyboard navigation to move focus between cotnrols
# * Setup dvorak
# * ctrl-option-command swicches input sources (this frees up ctrl-space for alfred)
# * set up bluetooth keyboard and trackpad
# * keyboard: capslock -> control
# * trackpad speed
#
# * sign in to 1password
# * Alfred license from 1password
# * gpg --import /Volumes/THEKEY/git-gpg-key.asc

# Ask for the administrator password upfront
sudo -v

###############
# OSX Settings

#######################
# Application Settings

# Set Alfred sync folder
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder -string ~/Dropbox/Preferences

# Set iterm2 sync folder
# defaults write com.googlecode.iterm2 PrefsCustomFolder -string ~/Dropbox/Preferences

######################
# Set up a few things

[ -d ~/src ] || mkdir ~/src
[ -e ~/src/dotfiles ] || ln -s ~/Dropbox/dotfiles ~/src/dotfiles
~/src/dotfiles/bin/link-dotfiles

###########
# Homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew bundle

# TODO: install pomo
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install lunarvim
# TODO: Lunarvim instalation asks questions, automate?
/bin/bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

# TODO: rustup-init

# TODO: copy .default-gems to rbenv install in /opt or move rbenv root to
# ~/.rbenv
# TODO: rbenv install latest ruby somehow?

# fonts from https://github.com/romkatv/powerlevel10k#installation
#
# * gh auth login
#
# * Install tpm plugins with prefix I in tmux
