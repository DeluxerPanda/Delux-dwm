#!/bin/bash
# Source interactive bash settings
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X on TTY1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi
