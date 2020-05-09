#!/usr/bin/env bash

cd ThePack
export MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
source compile.sh && source run.sh
