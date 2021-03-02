# Description
This is a bare minimum Docker based environment to deploy Magento 2 commerce edition.

# Requirements
* Running Docker daemon
* User is in docker group
* Composer is set up with credentials in `~/.config/composer`

# Instructions
In the `bin` folder you'll find various scripts:

1. `bin/magento-create-project.sh` Creates the Magento project using Composer.
2. `bin/magento-delete-project.sh` Deletes the Magento project including all files.
3. `bin/magento-delete-generated.sh` Deletes the Magento generated files.
4. `bin/magento-install.sh` Installs Magento with a basic configuration.
5. `bin/magento-install-sampledata.sh` Installs Magento sample data.
6. `bin/docker-compose-delete.sh` Stops running containers and removes all containers.
7. `bin/mysql-import.sh` Imports the provides mysqldump into the database.

In order to do a clean installation use following command combination:

```sh
./bin/docker-compose-delete.sh && \
./bin/magento-delete-project.sh && \
./bin/magento-create-project.sh && \
./bin/magento-install.sh && \
./bin/magento-install-sampledata.sh
```

# Magento commands
To access the Magento CLI run following command:
```
docker-compose run --rm php bin/magento
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

