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