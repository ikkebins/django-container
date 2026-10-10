#!/bin/sh
set -eu

cd "${APP_DIR:-/app}"

if [ "${1:-serve}" != "serve" ]; then
    exec "$@"
fi

if [ -f manage.py ]; then
    exec gunicorn "${DJANGO_WSGI_MODULE:-config.wsgi:application}" \
        --bind "0.0.0.0:${PORT:-8080}" \
        --workers "${WEB_CONCURRENCY:-2}" \
        --access-logfile - \
        --error-logfile -
else
    echo "Keine Django-Anwendung unter /app gefunden."
    echo "Platzhalter-Webseite wird gestartet."
    exec gunicorn placeholder:application \
        --chdir /opt/webapp \
        --bind "0.0.0.0:${PORT:-8080}" \
        --workers 1 \
        --access-logfile - \
        --error-logfile -
fi
