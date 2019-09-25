#!/bin/bash

PHP_ALIAS='php'
PHPUNIT_ALIAS='phpunit'

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
    printf "alias $PHP_ALIAS='docker exec -it \$(docker ps -f \"name=php\" --format \"{{.Names}}\") /usr/local/bin/php'" >> ~/.bash_aliases
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
    printf "alias $PHPUNIT_ALIAS='docker exec -it \$(docker ps -f \"name=php\" --format \"{{.Names}}\") /usr/local/bin/php ./vendor/bin/phpunit'" >> ~/.bash_aliases
else
    echo "Alias $PHPUNIT_ALIAS already exist!"
fi