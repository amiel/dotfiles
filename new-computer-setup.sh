#!/bin/bash


# First:
# 1. Update OSX
# 2. Install XCode
# 3. Copy ssh-keys (`scp x.x.x.x:'.ssh/id_rsa*' .ssh/`)
# 4. Install dropbox and start syncing

###############
# OSX Settings

# Do not beep when changing the volume
defaults write -g com.apple.sound.beep.feedback -bool false

# Show battery percentage
defaults write com.apple.menuextra.battery ShowTime -bool false
defaults write com.apple.menuextra.battery ShowPercent -bool true

# Disable dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Set trackpad speed
defaults write -g com.apple.trackpad.scaling -int 3
    
# Enable directory spring loading
defaults write -g com.apple.springing.enabled -bool true

# Remove spring loading delay
defaults write -g com.apple.springing.delay -int 0

# Enable AirDrop over ethernet
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true
