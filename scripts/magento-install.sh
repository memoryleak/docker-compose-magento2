#!/usr/bin/env bash
if [ $# -ne 1 ]
  then
    printf "${CYAN}USAGE: magento-install.sh <BASE_URL>${NC}\n"; exit;
fi

MAGENTO_BASE_URL=$1
CYAN='\033[0;36m'
NC='\033[0m' # No Color

printf "${CYAN}Make sure composer dependencies are installed${NC}\n"
docker-compose run --rm -w /var/www/html php-composer composer install

printf "${CYAN}Starting Magento installation${NC}\n"
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

printf "${CYAN}Starting setup:upgrade${NC}\n"
docker-compose run --rm -w /var/www/html php-composer php -d memory_limit=-1 bin/magento setup:upgrade

printf "${CYAN}Starting cache:clean${NC}\n"
docker-compose run --rm -w /var/www/html php-composer php -d memory_limit=-1 bin/magento cache:clean

printf "${CYAN}Setup permissions${NC}\n"
docker-compose run --rm -w /var/www/html php chown -R www-data:www-data .

printf "${CYAN}Starting chmod for files${NC}\n"
docker-compose run --rm -w /var/www/html php find var generated pub/static pub/media app/etc -type f -exec chmod g+w {} +

printf "${CYAN}Starting chmod for dirs${NC}\n"
docker-compose run --rm -w /var/www/html php find var generated pub/static pub/media app/etc -type d -exec chmod g+ws {} +
