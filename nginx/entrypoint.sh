#!/bin/sh
set -e

# Generate .htpasswd file with env vars
if [ -n "$BASIC_AUTH_USER" ] && [ -n "$BASIC_AUTH_PASSWORD" ]; then
    echo "Creating htpasswd file with user: $BASIC_AUTH_USER"
    htpasswd -bc /etc/nginx/.htpasswd "$BASIC_AUTH_USER" "$BASIC_AUTH_PASSWORD"
    # Verify the file was created properly
    echo "Verifying htpasswd file:"
    ls -la /etc/nginx/.htpasswd
    echo "File contents (encrypted):"
    cat /etc/nginx/.htpasswd
else
    echo "BASIC_AUTH_USER or BASIC_AUTH_PASSWORD not set!"
    exit 1
fi

# Substitute env vars in nginx_template.conf -> nginx.conf
echo "Generating nginx configuration..."
envsubst '$PROMETHEUS_INTERNAL_URL $LOKI_INTERNAL_URL $TEMPO_INTERNAL_URL' < /etc/nginx/nginx_template.conf > /etc/nginx/nginx.conf

# Make sure paths are properly set
echo "Ensuring paths for auth exist:"
mkdir -p /etc/nginx
chmod 755 /etc/nginx
chmod 644 /etc/nginx/.htpasswd

exec "$@"
