#!/bin/bash

set -e

. /etc/default/locale

export LANG
export LC_ALL

cd /var/opt/suap

. .env/bin/activate

exec celery -b redis://10.0.202.109:6379/3 flower --purge_offline_workers=1
