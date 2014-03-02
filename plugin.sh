#!/bin/sh

NAME=$1
URL=$2

git submodule add --force --name $1 $2 nvim/site/pack/bundle/opt/$1
