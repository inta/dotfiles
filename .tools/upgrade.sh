#!/bin/sh

brew update && brew upgrade && brew cleanup
brew cask update && brew cask cleanup
sh "$(dirname "$0")/cask-upgrade.sh" "$1"
sh "$(dirname "$0")/npm-upgrade.sh"
