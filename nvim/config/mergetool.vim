" disable all highlighting for diff view
syntax off
TSDisableAll highlight
" mergetool view with MERGED at the bottom
" and LOCAL - BASE - REMOTE at the top.
edit $MERGED
diffsplit $REMOTE
vert diffsplit $LOCAL
vert diffsplit $BASE
" move to merged file
wincmd j
