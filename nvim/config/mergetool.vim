" disable all highlighting for diff view
syntax off
TSDisableAll highlight
" mergetool view with MERGED at the bottom
" and LOCAL - BASE - REMOTE at the top.
edit $MERGED
diffsplit $LOCAL
vert diffsplit $BASE
vert diffsplit $REMOTE
" move to merged file
wincmd j
