#!/usr/bin/env bash
docker-compose run -w /var/www php-composer php -d memory_limit=-1 /usr/bin/composer create-project --repository=https://repo.magento.com/ magento/project-enterprise-edition=2.3.6 html --verbose
