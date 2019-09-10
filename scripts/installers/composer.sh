#!/bin/bash

DIR=`dirname $0`
COMPOSER_HOME=~/.config/composer
COMPOSER_CACHE_DIR=~/.cache/composer
COMPOSER_ALIAS='composer'

docker pull composer:latest

if [ ! -d "$COMPOSER_HOME" ]; then
    mkdir "$COMPOSER_HOME"
fi

if [ ! -d "$COMPOSER_CACHE_DIR" ]; then
    mkdir "$COMPOSER_CACHE_DIR"
fi

echo "Copying docker-composer.sh script to $COMPOSER_HOME/"
cp "$DIR/../runners/docker-composer.sh" "$COMPOSER_HOME/docker-composer"
chmod u+x "$COMPOSER_HOME/docker-composer"

echo "Checking for $COMPOSER_ALIAS alias..."
if [ ! -f ~/.bash_aliases ]; then
    touch ~/.bash_aliases
fi
grep -q "alias $COMPOSER_ALIAS" ~/.bash_aliases
missing_alias=$?

if [ $missing_alias = 1 ]; then
    echo "Alias $COMPOSER_ALIAS don't exist, adding it!"
    if [ -s ~/.bash_aliases ]; then
        echo >> ~/.bash_aliases
    fi
    printf "alias $COMPOSER_ALIAS=$COMPOSER_HOME/docker-composer" >> ~/.bash_aliases
else
    echo "Alias $COMPOSER_ALIAS already exist!"
fi