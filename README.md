# Description
This is a bare minimum Docker based environment to deploy Magento 2 commerce edition.

# Requirements
* Running Docker daemon
* User is in docker group
* Composer is set up with credentials in `~/.config/composer`

# Instructions
In the `bin` folder you'll find various scripts:

1. `scripts/magento-create-project.sh` Creates the Magento project using Composer.
2. `scripts/magento-delete-project.sh` Deletes the Magento project including all files.
3. `scripts/magento-delete-generated.sh` Deletes the Magento generated files.
4. `scripts/magento-install.sh` Installs Magento with a basic configuration.
5. `scripts/magento-install-sampledata.sh` Installs Magento sample data.
6. `scripts/docker-compose-delete.sh` Stops running containers and removes all containers.
7. `scripts/mysql-import.sh` Imports the provides mysqldump into the database.

In order to do a clean installation you have two options:
```sh
./scripts/magento-setup.sh 2.3.6 magento.localhost
```
This will execute these commands in the following order:
```sh
./scripts/docker-compose-delete.sh
./scripts/magento-delete-project.sh
./scripts/magento-create-project.sh 2.3.6
./scripts/magento-install.sh magento.localhost
./scripts/magento-install-sampledata.sh
```

Or you can execute these single commands to your liking.

# Commands
## Magento
To access the Magento CLI run following command:
```
bin/magento
```
## MySQL
```
bin/mysql
bin/mysqldump
```

## Backend
Go to `http://MAGENTO_BASE_URL/admin` with username `admin` and password `admin123_`

## Services
* RabbitMQ: `http://MAGENTO_BASE_URL:15672/` with username and password `magento`
* Mailhog: `http://MAGENTO_BASE_URL:8025/` with no credentials
* Kibana: `http://MAGENTO_BASE_URL:5601/` with no credentials
