#!/bin/bash


# First:
# 1. Update OSX
# 2. Install XCode
# 3. Install dropbox and start syncing
# 4. Copy ssh-keys (`scp x.x.x.x:'.ssh/id_rsa*' .ssh/`)
# 5. When XCode is done, install command-line-tools (`xcode-select --install`)

# Then, run this script

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

# Use scroll gesture with the Ctrl (^) key to zoom
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Use mouse wheel (scroll gesture) to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true


#########################
# Remap Caps Lock to Ctl

ioreg -n IOHIDKeyboard -r | grep -E 'VendorID"|ProductID' | awk '{ print $4 }' | paste -s -d'-\n' - | xargs -I{} defaults -currentHost write -g "com.apple.keyboard.modifiermapping.{}-0" -array "<dict><key>HIDKeyboardModifierMappingDst</key><integer>2</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>"


#######################
# Application Settings

# Set Alfred sync folder
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder -string ~/Dropbox/Alfred

# Set iterm2 sync folder
defaults write com.googlecode.iterm2 PrefsCustomFolder -string ~/Dropbox/Preferences

#########################
# Safari/WebKit settings

# nable Safari Developer Menu
defaults write com.apple.safari IncludeDevelopMenu -bool true

# Enable Safari Inspector
defaults write com.apple.safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# Enable Safari Inspector (again? cargo-culting here)
defaults write com.apple.safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add context menu for Safari Web Inspector
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

