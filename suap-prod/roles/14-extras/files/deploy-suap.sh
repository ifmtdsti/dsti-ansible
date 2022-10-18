#!/bin/bash

if [ "$USER" != "root" ] ; then

    echo "Este script só deve ser executado em modo root"
    exit 1

fi

set -e

supervisorctl stop all

cd /var/opt/suap

git fetch --all --prune

git pull origin master

. .env/bin/activate

python -m pip install --upgrade pip

python -m pip install -r requirements/custom.txt

python manage.py sync

chown -R www-data:www-data deploy/logs

supervisorctl start all
