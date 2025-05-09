#!/bin/sh
set -e

# Generate .htpasswd file with env vars
if [ -n "$BASIC_AUTH_USER" ] && [ -n "$BASIC_AUTH_PASSWORD" ]; then
    htpasswd -bc /etc/nginx/.htpasswd "$BASIC_AUTH_USER" "$BASIC_AUTH_PASSWORD"
else
    echo "BASIC_AUTH_USER or BASIC_AUTH_PASSWORD not set!"
    exit 1
fi

# Substitute env vars in nginx_template.conf -> nginx.conf
envsubst '$PROMETHEUS_INTERNAL_URL $LOKI_INTERNAL_URL $TEMPO_INTERNAL_URL' < /etc/nginx/nginx_template.conf > /etc/nginx/nginx.conf

exec "$@"
