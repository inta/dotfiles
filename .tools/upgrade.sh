#!/bin/sh

brew update && brew upgrade --all && brew cleanup
brew cask update && brew cask cleanup

npm update -g
