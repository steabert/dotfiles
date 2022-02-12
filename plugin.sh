#!/usr/bin/env bash
URL=$1
NAME=$(basename $URL .git)
git submodule add --force --name $NAME $URL nvim/site/pack/bundle/opt/$NAME
