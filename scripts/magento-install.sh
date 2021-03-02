#!/usr/bin/env bash
if [ $# -ne 1 ]
  then
    echo "USAGE: magento-install.sh <BASE_URL>"; exit;
fi

MAGENTO_BASE_URL=$1

echo "Starting composer dependency installation"
docker-compose run --rm -w /var/www/html php-composer bin/magento setup:install  \
	--backend-frontname admin \
	--amqp-host rabbitmq \
	--amqp-port 5672  \
	--amqp-user magento \
	--amqp-password magento \
	--amqp-virtualhost magento \
	--enable-debug-logging 1 \
	--db-host mysql \
	--db-name magento \
	--db-user magento \
	--db-password magento \
	--session-save redis \
	--session-save-redis-host redis \
	--session-save-redis-port 6379 \
	--session-save-redis-db 1 \
	--cache-backend redis \
	--cache-backend-redis-server redis \
	--cache-backend-redis-db 2 \
	--cache-backend-redis-port 6379 \
	--page-cache redis \
	--page-cache-redis-server redis \
	--page-cache-redis-db 3 \
	--page-cache-redis-port 6379 \
	--base-url http://$MAGENTO_BASE_URL \
	--language en_US \
	--timezone Europe/Zurich \
	--currency USD \
	--use-rewrites 1 \
	--use-secure 0 \
	--base-url-secure https://$MAGENTO_BASE_URL \
	--use-secure-admin 0 \
	--admin-user admin \
	--admin-password admin123_ \
	--admin-email admin@example.com \
	--admin-firstname ADMIN-FIRSTNAME  \
	--admin-lastname ADMIN-LASTNAME

echo "Starting setup:upgrade"
docker-compose run --rm -w /var/www/html php-composer php -d memory_limit=-1 bin/magento setup:upgrade
docker-compose run --rm -w /var/www/html php-composer php -d memory_limit=-1 bin/magento cache:clean

echo "Setup permissions"
docker-compose run --rm -w /var/www/html php chown -R www-data:www-data .
docker-compose run --rm -w /var/www/html php find var generated pub/static pub/media app/etc -type f -exec chmod g+w {} +
docker-compose run --rm -w /var/www/html php find var generated pub/static pub/media app/etc -type d -exec chmod g+ws {} +

echo "Start docker-compose environment"
docker-compose up -d
