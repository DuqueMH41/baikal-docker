#!/bin/sh
set -e

echo "Baikal entrypoint starting..."

# Ensure required directories exist
mkdir -p /var/www/baikal/config /var/www/baikal/Specific

echo "Fixing permissions..."
chown -R www-data:www-data /var/www/baikal/config /var/www/baikal/Specific || true

echo "Starting Apache..."
exec apache2-foreground
