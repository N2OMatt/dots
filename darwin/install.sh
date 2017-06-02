#!/bin/bash
################################################################################
## File    : install.sh                                                       ##
## Project : dots                                                             ##
## License : GPLv3                                                            ##
## Author  : n2omatt@amazingcow.com                                           ##
##                                                                            ##
## Description:                                                               ##
## Installation script for Cygwin machines.                                   ##
################################################################################


################################################################################
## Variables                                                                  ##
################################################################################
OS=$1;
DOTS_DIR=$2


BASE_FILES="AmazingCow.sh                \
            bash-status-line_bindings.sh \
            development.sh               \
            git.sh                       \
            hacks.sh                     \
            TBS.sh                       \
            ps1.sh";

LOCAL_FILES="files.sh    \
             coreutils.sh";


################################################################################
## Script                                                                     ##
################################################################################
echo "----> Calling dots install_helper.sh";
echo "------> OS       : $OS";
echo "------> DOTS_DIR : $DOTS_DIR";

./install_helper.sh             \
    --basedir    "./base"       \
    --localdir   "$OS"          \
    --outputdir  "./output"     \
    --dotsdir    "$DOTS_DIR"    \
    --basefiles  "$BASE_FILES"  \
    --localfiles "$LOCAL_FILES"


echo "----> Configuring OSX defaults...";
## Based on:
##   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
## Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
## Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
## Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
## Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"
## Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
## Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
## Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
## Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
## Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
## Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 7
defaults write NSGlobalDomain InitialKeyRepeat -int 25
## Set Desktop as the default location for new Finder windows
## For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
## Finder: show hidden files by default
#defaults write com.apple.finder AppleShowAllFiles -bool true
##Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
## Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
## Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
## Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
## Use list view in all Finder windows by default
## Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
## Show the ~/Library folder
chflags nohidden ~/Library
## Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36
## Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true
## Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true
## Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false
## Enable “focus follows mouse” for Terminal.app and all X11 apps
## i.e. hover over a window and start typing in it without clicking first
defaults write com.apple.terminal FocusFollowsMouse -bool true
defaults write org.x.X11 wm_ffm -bool true

