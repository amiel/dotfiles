#!/bin/bash


# First:
# 1. Update OSX
# 2. Set keyboard layout (I use Dvorak)
# 3. Set Caps Lock -> Control in modifier keys
# 5. Copy ssh-keys (`scp x.x.x.x:'.ssh/id_rsa*' .ssh/`, or use usb key)
# 6. Install homebrew (docs.brew.sh/Installation)
# 7. mkdir src && cd src && git clone https://github.com/amiel/dotfiles
# 8. cd ~/src/dotfiles
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
# * gpg --import /Volumes/THEKEY/git-gpg-key.asc


# Ask for the administrator password upfront
# sudo -v

###############
# OSX Settings

######################
# Set up a few things

# [ -d ~/src ] || mkdir ~/src
# [ -e ~/src/dotfiles ] || ln -s ~/Dropbox/dotfiles ~/src/dotfiles
# ~/src/dotfiles/bin/link-dotfiles

stow -v --dotfiles -t ~ -d ~/src/dotfiles --no-folding --ignore '.DS_Store' -S home

###########
# Homebrew

# eval "$(/opt/homebrew/bin/brew shellenv)"

# brew bundle

# TODO: install pomo
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# TODO: rustup-init
#
# TODO: mise

#####
# raycast
#
# setup with hotkey ^-space (note you have to change keyboard shotcut to switch input sources from ^-space)

# fonts from https://github.com/romkatv/powerlevel10k#installation
#
# * gh auth login
#
# * Install tpm plugins with prefix I in tmux
