#!/usr/bin/env bash
if [ $# -ne 1 ]
  then
    echo "USAGE: magento-create-project.sh <VERSION>"; exit;
fi

MAGENTO_VERSION=$1

docker-compose run --rm -w /var/www php-composer php -d memory_limit=-1 /usr/bin/composer create-project --repository=https://repo.magento.com/ magento/project-enterprise-edition="$MAGENTO_VERSION" html
