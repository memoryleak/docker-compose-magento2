# Description
This is a bare minimum Docker based environment to run Magento 2 commerce edition.

# Instructions
Install Magento2 first:
```
composer create-project --repository=https://repo.magento.com/ magento/project-enterprise-edition=2.3.6 html --verbose --ignore-platform-reqs
```
1. Copy your `~/.composer/auth.json` to `html/auth.json`
1. Start the environment via  `docker-compose up -d`
1. Install Magento `docker-compose exec -e MAGENTO_BASE_URL=local-mg2.localhost php install-magento` 
1. Run Magento commands with  `docker-compose exec php bin/magento`

## Sample data
* `docker-compose exec php php -d memory_limit=-1 bin/magento sampledata:deploy`
* `docker-compose exec php php bin/magento setup:upgrade`
* `docker-compose exec php php bin/magento indexer:reindex`
* `docker-compose exec php php bin/magento cache:clean`

## Backend
Go to `http://MAGENTO_BASE_URL/admin` with username `admin` and password `admin123_`

## Services
* RabbitMQ: `http://MAGENTO_BASE_URL:15672/` with username and password `magento`
* Mailhog: `http://MAGENTO_BASE_URL:8025/` with no credentials
* Kibana: `http://MAGENTO_BASE_URL:5601/` with no credentials

## Varnish
Follow [Official docs](https://devdocs.magento.com/guides/v2.4/config-guide/varnish/config-varnish-magento.html) to configure
Varnish. Use following specific values:

* **Backend host** : `nginx`
* **Access list** : `php`

## Elasticsearch
Follow [Official docs](https://devdocs.magento.com/guides/v2.4/config-guide/elasticsearch/configure-magento.html) to 
configure ElasticSearch. Use `elasticsearch` as the host. 

## xdebug
Enable the module in `php/xdebug.ini`. Make sure the `PHP_IDE_CONFIG` environment variable is matching your PHPStorm 
setting for `serverName`.