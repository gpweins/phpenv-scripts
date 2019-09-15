#!/bin/bash

DIR=`dirname $0`
COMPOSER_ALIAS=${1:-'composer'}
COMPOSER_TAG=${2:-'latest'}

COMPOSER_HOME="$HOME/.config/composer-${COMPOSER_TAG}/"
COMPOSER_CACHE_DIR="$HOME/.cache/composer-${COMPOSER_TAG}/"

echo "Pulling composer:$COMPOSER_TAG from Docker Hub"
docker pull "composer:$COMPOSER_TAG"

if [ ! -d "$COMPOSER_HOME" ]; then
    mkdir "$COMPOSER_HOME"
fi

if [ ! -d "$COMPOSER_CACHE_DIR" ]; then
    mkdir "$COMPOSER_CACHE_DIR"
fi

echo "Copying docker-composer.sh script to $COMPOSER_HOME/"
cp "$DIR/../runners/docker-composer.sh" "$COMPOSER_HOME/docker-composer-${COMPOSER_TAG}"
sed -i "s|COMPOSER_TAG|$COMPOSER_TAG|g" "$COMPOSER_HOME/docker-composer-${COMPOSER_TAG}"
chmod u+x "$COMPOSER_HOME/docker-composer-${COMPOSER_TAG}"

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
    printf "alias $COMPOSER_ALIAS=$COMPOSER_HOME/docker-composer-${COMPOSER_TAG}" >> ~/.bash_aliases
else
    echo "Alias $COMPOSER_ALIAS already exist!"
fi