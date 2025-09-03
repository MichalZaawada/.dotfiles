#!/usr/bin/env bash

dir="$HOME/.config/rofi"

## Run
rofi \
    rofi -modi clipboard:~/.config/rofi/rofi-scripts/clipboard/cliphist-rofi -show clipboard

