#!/usr/bin/env sh
set -e

if [ "$LARAVEL_ENV" == "dev" ]; then
  cd /var/www/html
  exec composer install
fi

exec "$@"
