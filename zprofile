# Start window manager
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    XKB_DEFAULT_LAYOUT=us exec sway > $HOME/.sway.log 2>&1
fi
