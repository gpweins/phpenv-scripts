#!/bin/bash

DIR=`dirname $0`

PHP_ALIAS=${1:-'php'}
PHP_TAG=${2:-'latest'}
PHPUNIT_ALIAS=${3:-'phpunit'}

PHP_HOME="$HOME/.config/php-cli-$PHP_TAG"

if [ ! -d "$PHP_HOME" ]; then
    mkdir "$PHP_HOME"
fi

docker pull "php:$PHP_TAG"

echo "Copying docker-php script to $PHP_HOME/"
cp "$DIR/../runners/docker-php.sh" "$PHP_HOME/docker-php-$PHP_TAG"
sed -i "s|PHP_TAG|$PHP_TAG|g" "$PHP_HOME/docker-php-$PHP_TAG"
chmod u+x "$PHP_HOME/docker-php-$PHP_TAG"

echo "Checking for $PHP_ALIAS alias..."
if [ ! -f ~/.bash_aliases ]; then
    touch ~/.bash_aliases
fi
grep -q "alias $PHP_ALIAS" ~/.bash_aliases
missing_alias=$?

if [ $missing_alias = 1 ]; then
    echo "Alias $PHP_ALIAS don't exist, adding it!"
    if [ -s ~/.bash_aliases ]; then
        echo >> ~/.bash_aliases
    fi
    printf "alias $PHP_ALIAS=$PHP_HOME/docker-php-$PHP_TAG" >> ~/.bash_aliases
else
    echo "Alias $PHP_ALIAS already exist!"
fi

echo "Checking for $PHPUNIT_ALIAS alias..."
grep -q "alias $PHPUNIT_ALIAS" ~/.bash_aliases
missing_alias=$?

if [ $missing_alias = 1 ]; then
    echo "Alias $PHPUNIT_ALIAS don't exist, adding it!"
    if [ -s ~/.bash_aliases ]; then
        echo >> ~/.bash_aliases
    fi
    printf "alias $PHPUNIT_ALIAS='$PHP_HOME/docker-php-$PHP_TAG vendor/phpunit/phpunit/phpunit'" >> ~/.bash_aliases
else
    echo "Alias $PHPUNIT_ALIAS already exist!"
fi