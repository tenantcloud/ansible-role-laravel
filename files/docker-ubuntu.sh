#!/usr/bin/env bash

# Prepare local nginx server
sh/install/nginx-from-ansible.sh

docker-compose exec -T mysql /app/sh/install/prepare-mysql.sh
docker-compose exec -T app composer install --no-interaction --prefer-dist --optimize-autoloader
docker-compose exec -T app php artisan migrate
docker-compose exec -T app php artisan db:seed
docker-compose exec -T app php artisan key:generate
docker run --rm -t -v "$PWD":/app -w /app tenantcloud/docker-pipeline npm i
