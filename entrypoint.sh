#!/bin/sh

echo "Fixing permissions..."
chown -R www-data:www-data /var/www/baikal/config
chown -R www-data:www-data /var/www/baikal/Specific

echo "Starting Apache..."
exec apache2-foreground
