#!/bin/sh

COMPOSER_HOME=$HOME/.config/composer
COMPOSER_CACHE_DIR=$HOME/.cache/composer

docker run -it --rm \
  --env COMPOSER_HOME \
  --env COMPOSER_CACHE_DIR \
  --volume $COMPOSER_HOME:$COMPOSER_HOME \
  --volume $COMPOSER_CACHE_DIR:$COMPOSER_CACHE_DIR \
  --volume $PWD:/app \
  --user $(id -u):$(id -g) \
  composer "$@"