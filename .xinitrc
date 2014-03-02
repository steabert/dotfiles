#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# detect and set monitor(s), enable
# keyboard layouts accordingly, set
# correct compose-key
dual-monitor-setup

# set background
wallpaper

# set default cursor
xsetroot -cursor_name left_ptr

# disable system beep
xset b off

# enable X resources (urxvt settings)
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# now start the terminal daemon (needs Xresourses)
urxvtd -q -f -o

# set GTK theme location (for QGtkStyle)
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# start GPG agent
eval $(gpg-agent --daemon)

# start loop to set status
while true; do dwm_status; sleep 60; done &

# start window manager
exec dwm
