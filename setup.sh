#!/usr/bin/env bash

brew tap homebrew/science
brew cask install xquartz
brew install r

# TODO automate this step
echo "Run R, then enter the following: install.packages('qcc')"
