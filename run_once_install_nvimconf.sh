#!/bin/bash

# Required
mv ~/.config/nvim{,.bak}

# Recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

# Install
git clone git@github.com:czyrar/nvim.git ~/.config/nvim
