edit $MERGED
diffsplit $LOCAL
vert diffsplit $BASE
vert diffsplit $REMOTE
wincmd j
syntax off
TSDisableAll highlight
