# Description
This is a bare minimum Docker based environment to deploy Magento 2 commerce edition.

# Instructions
Execute `deploy.sh MAGENTO_BASE_URL` with the desired base url as the parameter.

# Magento commands
Simply execute followiinig command in the location of your `docker-compose.yml`
```
docker-compose exec -w /var/www/html php \
	php -d memory_limit=-1 bin/magento
```

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
setting for `serverName` in the `docker-compose.yml` file.
