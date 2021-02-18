#!/usr/bin/env bash
if [ $# -eq 0 ]
  then
    echo "Please suply the BASE_URL value as parameter."; exit;
fi

MAGENTO_BASE_URL=$1

echo "Using $MAGENTO_BASE_URL as the base url"

docker-compose stop ; docker-compose rm -f ; docker volume prune -f
docker-compose up -d
docker-compose exec php rm -rf html

docker-compose exec php composer create-project \
	--repository=https://repo.magento.com/ \
	magento/project-enterprise-edition=2.3.6 \
	/var/www/html

docker-compose exec -w /var/www/html php \
	php -d memory_limit=-1 bin/magento setup:install \
	--backend-frontname=admin \
	--amqp-host=rabbitmq \
	--amqp-port=5672 \
	--amqp-user=magento \
	--amqp-password=magento \
	--amqp-virtualhost=magento \
	--enable-debug-logging=1 \
	--db-host=mysql \
	--db-name=magento \
	--db-user=magento \
	--db-password=magento \
	--http-cache-hosts=varnish \
	--session-save=redis \
	--session-save-redis-host=redis \
	--session-save-redis-port=6379 \
	--session-save-redis-db=1 \
	--cache-backend=redis \
	--cache-backend-redis-server=redis \
	--cache-backend-redis-db=2 \
	--cache-backend-redis-port=6379 \
	--page-cache=redis \
	--page-cache-redis-server=redis \
	--page-cache-redis-db=3 \
	--page-cache-redis-port=6379 \
	--lock-provider=db \
	--base-url=http://$MAGENTO_BASE_URL/ \
	--language=en_US \
	--timezone=UTC \
	--currency=USD \
	--use-rewrites=1 \
	--use-secure=0 \
	--base-url-secure=https://$MAGENTO_BASE_URL/ \
	--use-secure-admin=0 \
	--admin-user=admin \
	--admin-password=admin123_ \
	--admin-email=admin@example.com \
	--admin-firstname=ADMIN-FIRSTNAME \
	--admin-lastname=ADMIN-LASTNAME

docker-compose exec -w /var/www/html php ln -s /root/.composer/auth.json
docker-compose exec -w /var/www/html php php -d memory_limit=-1 bin/magento sampledata:deploy
docker-compose exec -w /var/www/html php php -d memory_limit=-1 bin/magento setup:upgrade
docker-compose exec -w /var/www/html php php -d memory_limit=-1 bin/magento cache:clean
docker-compose exec -w /var/www/html php chown -R www-data:www-data .
docker-compose exec -w /var/www/html php find var generated pub/static pub/media app/etc -type f -exec chmod g+w {} + &&
docker-compose exec -w /var/www/html php find var generated pub/static pub/media app/etc -type d -exec chmod g+ws {} +
