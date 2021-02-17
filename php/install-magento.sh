#!/usr/bin/env bash
cd /usr/share/nginx/html || exit;

rm -rf var/cache/*
rm -rf generated/metadata/*
rm -rf generated/code/*
rm -rf var/view_preprocessed/*
rm -rf pub/static/*

bin/magento setup:install \
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
	--use-secure-admin=1 \
	--admin-user=admin \
	--admin-password=admin123_ \
	--admin-email=admin@example.com \
	--admin-firstname=ADMIN-FIRSTNAME \
	--admin-lastname=ADMIN-LASTNAME

