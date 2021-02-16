# Description
This is a bare minimum Docker based environment to run Magento 2 commerce edition.

# Instructions
Install Magento2 first:
```
composer create-project --repository=https://repo.magento.com/ magento/project-enterprise-edition=2.3.6 html --verbose --ignore-platform-reqs
```
1. Copy your `~/.composer/auth.json` to `html/auth.json`
1. Start the environment via  `docker-compose up -d`
1. Install Magento and sample-data with  `docker-compose exec -e MAGENTO_BASE_URL=local-mg2.localhost php install-magento` 
