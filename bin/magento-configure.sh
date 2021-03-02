#!/usr/bin/env bash
docker-compose run --rm php bin/magento config:set system/full_page_cache/varnish/access_list "php"
docker-compose run --rm php bin/magento config:set system/full_page_cache/varnish/backend_host "nginx"
docker-compose run --rm php bin/magento config:set system/full_page_cache/varnish/backend_port "80"
docker-compose run --rm php bin/magento config:set system/full_page_cache/varnish/grace_period "300"
docker-compose run --rm php bin/magento config:set system/full_page_cache/caching_application "2"
docker-compose run --rm php bin/magento config:set catalog/search/elasticsearch7_enable_auth "0"
docker-compose run --rm php bin/magento config:set catalog/search/elasticsearch7_index_prefix "magento2"
docker-compose run --rm php bin/magento config:set catalog/search/elasticsearch7_server_hostname "elasticsearch"
docker-compose run --rm php bin/magento config:set catalog/search/elasticsearch7_server_port "9200"
docker-compose run --rm php bin/magento config:set catalog/search/elasticsearch7_server_timeout "15"
docker-compose run --rm php bin/magento config:set catalog/search/engine "elasticsearch7"
docker-compose run --rm php bin/magento cache:flush
docker-compose run --rm php bin/magento indexer:reindex
