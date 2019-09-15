#!/bin/bash

DIR=`dirname $0`
PHP_HOME=~/.config/php-cli

if [ ! -d "$PHP_HOME" ]; then
    mkdir "$PHP_HOME"
fi

docker pull php:7.3-cli-alpine

echo "Copying docker-php script to $PHP_HOME/"
cp "$DIR/../runners/docker-php.sh" "$PHP_HOME/docker-php"
chmod u+x "$PHP_HOME/docker-php"

echo "Checking for php alias..."
if [ ! -f ~/.bash_aliases ]; then
    touch ~/.bash_aliases
fi
grep -q "alias php" ~/.bash_aliases
missing_alias=$?

if [ $missing_alias = 1 ]; then
    echo "PHP alias don't exist, adding it!"
    if [ -s ~/.bash_aliases ]; then
        echo >> ~/.bash_aliases
    fi
    printf "alias php=$PHP_HOME/docker-php" >> ~/.bash_aliases
else
    echo "PHP alias already exist!"
fi

echo "Checking for phpunit alias..."
grep -q "alias phpunit" ~/.bash_aliases
missing_alias=$?

if [ $missing_alias = 1 ]; then
    echo "PHPUnit alias don't exist, adding it!"
    if [ -s ~/.bash_aliases ]; then
        echo >> ~/.bash_aliases
    fi
    printf "alias phpunit='$PHP_HOME/docker-php vendor/phpunit/phpunit/phpunit'" >> ~/.bash_aliases
else
    echo "PHPUnit alias already exist!"
fi