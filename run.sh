#!/usr/bin/env bash

if [ -z "$MYSQL_ROOT_PASSWORD" ]
then
    echo "\$MYSQL_ROOT_PASSWORD is empty"
    exit 1
fi

DATA_DIR="/mnt/disks/msps-disk-1/mysql-data-dir"

docker build -t odinms_mysql odinms_mysql
docker build -t odinms odinms

ODINMS_MYSQL_CONTAINER_ID=`docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} -v $DATA_DIR:/var/lib/mysql odinms_mysql`

ODINMS_MYSQL_CONTAINER_IP_ADDRESS=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' $ODINMS_MYSQL_CONTAINER_ID`

# docker run -it --rm -e ODINMS_MYSQL_CONTAINER_IP_ADDRESS=$ODINMS_MYSQL_CONTAINER_IP_ADDRESS -p 7575:7575 -p 7576:7576 -p 7577:7577 -p 7578:7578 -p 8484:8484 odinms bash -c 'source compile_and_run.sh'
docker run -it --rm -e ODINMS_MYSQL_CONTAINER_IP_ADDRESS=$ODINMS_MYSQL_CONTAINER_IP_ADDRESS -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} -p 7575:7575 -p 7576:7576 -p 7577:7577 -p 7578:7578 -p 8484:8484 odinms bash

docker rm -f $ODINMS_MYSQL_CONTAINER_ID
