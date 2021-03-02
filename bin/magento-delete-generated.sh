#!/usr/bin/env bash
docker-compose exec -w /var/www/html php rm -rf var/cache/*
docker-compose exec -w /var/www/html php rm -rf generated/metadata/*
docker-compose exec -w /var/www/html php rm -rf generated/code/*
docker-compose exec -w /var/www/html php rm -rf var/view_preprocessed/*
docker-compose exec -w /var/www/html php rm -rf pub/static/*
