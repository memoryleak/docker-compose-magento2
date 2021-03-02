#!/usr/bin/env bash
if [ $# -eq 0 ]
  then
    echo "Please supply the path to the MySQL dump to import"; exit;
fi

MYSQL_DUMP_PATH=$1
pv $MYSQL_DUMP_PATH | docker-compose exec sh -c 'mysql -proot -D magento'
