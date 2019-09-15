docker run -it --rm \
  --volume $PWD:/usr/src/app \
  --workdir /usr/src/app \
  --user $(id -u):$(id -g) \
  php:PHP_TAG \
  php "$@"