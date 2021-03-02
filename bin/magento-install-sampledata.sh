#!/usr/bin/env bash
docker-compose run php-composer rm -rf /var/www/html/var/composer_home
docker-compose run php-composer ln -s /root/.composer /var/www/html/var/composer_home
docker-compose run php-composer php -d memory_limit=-1 bin/magento sampledata:deploy
docker-compose run php-composer php -d memory_limit=-1 bin/magento setup:upgrade
docker-compose run php-composer php -d memory_limit=-1 bin/magento cache:flush
docker-compose run php-composer php -d memory_limit=-1 bin/magento indexer:reindex
