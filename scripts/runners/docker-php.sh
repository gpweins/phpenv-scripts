docker run -it --rm \
  --volume $PWD:/usr/src/app \
  --workdir /usr/src/app \
  --user $(id -u):$(id -g) \
  php:7.3-cli-alpine \
  php "$@"