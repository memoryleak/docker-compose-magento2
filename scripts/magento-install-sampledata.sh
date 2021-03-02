#!/usr/bin/env bash
CYAN='\033[0;36m'
NC='\033[0m' # No Color

printf "${CYAN}Setup permissions${NC}\n"
docker-compose run --rm -w /var/www/html php chown -R www-data:www-data .
docker-compose run --rm -w /var/www/html php find var generated pub/static pub/media app/etc -type f -exec chmod g+w {} +
docker-compose run --rm -w /var/www/html php find var generated pub/static pub/media app/etc -type d -exec chmod g+ws {} +

printf "${CYAN}Remove composer_home and link /root/.composer${NC}\n"
docker-compose run --rm php-composer rm -rf /var/www/html/var/composer_home
docker-compose run --rm php-composer ln -s -T /root/.composer /var/www/html/var/composer_home

printf "${CYAN}Starting installing sample data${NC}\n"
docker-compose run --rm php-composer php -d memory_limit=-1 bin/magento sampledata:deploy

printf "${CYAN}Starting setup:upgrade${NC}\n"
docker-compose run --rm php-composer php -d memory_limit=-1 bin/magento setup:upgrade

printf "${CYAN}Starting cache:flush${NC}\n"
docker-compose run --rm php-composer php -d memory_limit=-1 bin/magento cache:flush
