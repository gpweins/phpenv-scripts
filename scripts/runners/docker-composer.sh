#!/bin/sh

COMPOSER_HOME=$HOME/.config/composer
COMPOSER_HOME_LOCAL=$COMPOSER_HOME-COMPOSER_TAG
COMPOSER_CACHE_DIR=$HOME/.cache/composer-COMPOSER_TAG

docker run -it --rm \
  --env COMPOSER_HOME \
  --env COMPOSER_CACHE_DIR \
  --volume $COMPOSER_HOME_LOCAL:$COMPOSER_HOME \
  --volume $COMPOSER_CACHE_DIR:/.composer/cache/ \
  --volume $PWD:/app \
  --user $(id -u):$(id -g) \
  composer:COMPOSER_TAG "$@"
