#!/bin/bash


# First:
# 1. Update OSX
# 2. Install XCode
# 3. Install dropbox and start syncing
# 4. Copy ssh-keys (`scp x.x.x.x:'.ssh/id_rsa*' .ssh/`)
# 5. When XCode is done, install command-line-tools (`xcode-select --install`)

# Then, run this script

# Ask for the administrator password upfront
sudo -v

###############
# OSX Settings

# Do not beep when changing the volume
defaults write NSGlobalDomain com.apple.sound.beep.feedback -float 0

# Expand save dialogs by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true

# Show battery percentage
defaults write com.apple.menuextra.battery ShowTime -bool false
defaults write com.apple.menuextra.battery ShowPercent -bool true

# Disable dashboard
defaults write com.apple.dashboard mcx-disabled -bool true
defaults write com.apple.dock 'dashboard-in-overlay' -bool false

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

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Use scroll gesture with the Ctrl (^) key to zoom
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Use mouse wheel (scroll gesture) to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Add iOS Simulator to Launchpad
sudo ln -sf /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app /Applications/iOS\ Simulator.app


#########################
# Remap Caps Lock to Ctl

ioreg -n IOHIDKeyboard -r | grep -E 'VendorID"|ProductID' | awk '{ print $4 }' | paste -s -d'-\n' - | xargs -I{} defaults -currentHost write -g "com.apple.keyboard.modifiermapping.{}-0" -array "<dict><key>HIDKeyboardModifierMappingDst</key><integer>2</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>"


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

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

############
# Spotlight

# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# Change indexing order and disable some file types
defaults write com.apple.spotlight orderedItems -array \
        '{"enabled" = 1;"name" = "APPLICATIONS";}' \
        '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
        '{"enabled" = 1;"name" = "DIRECTORIES";}' \
        '{"enabled" = 1;"name" = "PDF";}' \
        '{"enabled" = 1;"name" = "FONTS";}' \
        '{"enabled" = 0;"name" = "DOCUMENTS";}' \
        '{"enabled" = 0;"name" = "MESSAGES";}' \
        '{"enabled" = 0;"name" = "CONTACT";}' \
        '{"enabled" = 0;"name" = "EVENT_TODO";}' \
        '{"enabled" = 0;"name" = "IMAGES";}' \
        '{"enabled" = 0;"name" = "BOOKMARKS";}' \
        '{"enabled" = 0;"name" = "MUSIC";}' \
        '{"enabled" = 0;"name" = "MOVIES";}' \
        '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
        '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
        '{"enabled" = 0;"name" = "SOURCE";}'
# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null


###################
# Activity Monitor

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0




#######################
# Application Settings

# Set Alfred sync folder
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder -string ~/Dropbox/Alfred

# Set iterm2 sync folder
defaults write com.googlecode.iterm2 PrefsCustomFolder -string ~/Dropbox/Preferences

###############################
# Sync Sublime Text 2 settings
function setupstsync() {
  local stdir=~/"Library/Application Support/Sublime Text 2"
  local dropboxdir=~/"Dropbox/Sublime Text 2"
  if [ ! -d "$stdir" ];then
    mkdir -p "$stdir"
    ln -s "$dropboxdir/Installed Packages" "$stdir/Installed Packages"
    ln -s "$dropboxdir/Packages" "$stdir/Packages"
    ln -s "$dropboxdir/Pristine Packages" "$stdir/Pristine Packages"
  fi
}

setupstsync

######################
# Set up a few things

[ -d ~/src ] || mkdir ~/src
[ -e ~/src/dotfiles ] || ln -s ~/Dropbox/dotfiles ~/src/dotfiles
~/src/dotfiles/bin/link-dotfiles

launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

###########
# Homebrew

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brew install git
brew install reattach-to-user-namespace tmux
brew install bash-completion

brew tap phinze/cask
brew install brew-cask
brew tap caskroom/fonts

brew cask install font-inconsolata
brew cask install font-inconsolata-dz
brew cask install font-inconsolata-dz-for-powerline

# brew cask install dropbox # theoretically already installed
brew cask install google-chrome
brew cask install alfred
brew cask alfred link
brew cask install iterm2
brew cask install onepassword
brew cask install transmit
brew cask install sublime-text
brew cask install teleport
brew cask install github
brew cask install flowdock
brew cask install chronomate

brew tap homebrew/versions
brew install apple-gcc42

brew install ssh-copy-id
brew install colordiff
brew install mobile-shell
brew install imagemagick
brew install node
brew install nmap
brew install the_silver_searcher
brew install wget
brew install watch
brew install v8
brew install memcached
brew install redis
brew install postgresql
brew install mysql
brew install gnupg
brew install blink1

brew cask install firefox
brew cask install codekit
brew cask install skype
brew cask install heroku-toolbelt
brew cask install airfoil
brew cask install google-hangouts
brew cask install gitx
brew cask install vagrant

# ql plugins
brew cask install jsonlook
brew cask install qlmarkdown
brew cask install qlprettypatch

# extra
# brew cask install vlc
# brew cask install transmission
# brew cask install time-tracker-mac
# brew install sleepwatcher

#######
# Ruby

brew install rbenv ruby-build

