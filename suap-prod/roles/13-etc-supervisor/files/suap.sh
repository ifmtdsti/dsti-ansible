#!/bin/bash

set -e

LOGFILE=/var/opt/suap/deploy/logs/gunicorn/suap.log

LOGDIR=$(dirname ${LOGFILE})

test -d ${LOGDIR} || mkdir -p ${LOGDIR}

WORKERS=$(($(nproc)/4))

USER=suap

. /etc/default/locale

export LANG
export LC_ALL

. /var/opt/suap/.env/bin/activate

cd /var/opt/suap

exec gunicorn suap.wsgi:application -b 0.0.0.0:8000 -w ${WORKERS} -t 300 -u ${USER} -g ${USER} --max-requests=1000 --max-requests-jitter=30 --capture-output --log-level=critical --log-file=${LOGFILE}
