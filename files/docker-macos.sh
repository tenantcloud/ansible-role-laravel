#!/usr/bin/env bash

# Prepare local nginx server
sh/install/nginx-from-ansible.sh

# Get DOCKER_APP_NAME from .env
if [[ -n $(sed -n -e "s/^DOCKER_APP_NAME=//p" .env ) ]]; then
  DOCKER_APP_NAME=$(sed -n -e "s/^DOCKER_APP_NAME=//p" .env )
fi

docker-compose exec -T mysql /app/sh/install/prepare-mysql.sh
docker run --rm -i --mount source="${DOCKER_APP_NAME:-laravel}"-nfsmount,target=/app tenantcloud/composer \
  composer install --no-interaction --prefer-dist --optimize-autoloader
docker run --rm -it --network="${DOCKER_APP_NAME:-laravel}"-network --mount source="${DOCKER_APP_NAME:-laravel}"-nfsmount,target=/app \
  -w /app --entrypoint "/app/sh/install/minio.sh" minio/mc:latest
docker-compose exec -T app php artisan migrate
docker-compose exec -T app php artisan db:seed
docker-compose exec -T app php artisan key:generate
docker run --rm -t -v "$PWD":/app -w /app tenantcloud/docker-pipeline npm i
