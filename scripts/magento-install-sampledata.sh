#!/usr/bin/env bash
echo "Setup permissions"
docker-compose run --rm -w /var/www/html php chown -R www-data:www-data .
docker-compose run --rm -w /var/www/html php find var generated pub/static pub/media app/etc -type f -exec chmod g+w {} +
docker-compose run --rm -w /var/www/html php find var generated pub/static pub/media app/etc -type d -exec chmod g+ws {} +

docker-compose run --rm php-composer rm -rf /var/www/html/var/composer_home
docker-compose run --rm php-composer ln -s -T /root/.composer /var/www/html/var/composer_home

docker-compose run --rm php-composer php -d memory_limit=-1 bin/magento sampledata:deploy
docker-compose run --rm php-composer php -d memory_limit=-1 bin/magento setup:upgrade
docker-compose run --rm php-composer php -d memory_limit=-1 bin/magento cache:flush
