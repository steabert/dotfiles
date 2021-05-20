# Start window manager
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
        XKB_DEFAULT_LAYOUT=us exec sway >$HOME/.sway.log 2>&1
else
        # Increase mouse keys sensitivity
        xkbset ma 50 20 20 30 300
fi
