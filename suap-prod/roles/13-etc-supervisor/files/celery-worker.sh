#!/bin/bash

set -e

. /etc/default/locale

export LANG
export LC_ALL

. /var/opt/suap/.env/bin/activate

cd /var/opt/suap

exec celery -A suap worker -l INFO -Q geral
