#!/bin/sh
set -e

echo "Waiting for MariaDB at $WP_SQL_HOST:$WP_SQL_PORT..."
until mariadb-admin ping -h "$WP_SQL_HOST" -P "$WP_SQL_PORT" -u "$WP_SQL_USER" -p"$WP_SQL_PASSWORD" --silent; do
    sleep 2
done

if [ ! -f "wp-config.php" ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --allow-root \
        --dbname="$WP_SQL_DATABASE" \
        --dbuser="$WP_SQL_USER" \
        --dbpass="$WP_SQL_PASSWORD" \
        --dbhost="$WP_SQL_HOST" \
        --locale=fr_FR
fi

chown -R www-data:www-data /var/www/wordpress

if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    wp core install \
        --url="https://$DOMAIN_NAME" \
        --title="Cloud-1" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root
else
    echo "WordPress already installed. Checking for DB updates..."
    wp core update-db --allow-root
fi

if [ -n "$THEME" ]; then
    wp theme install "$THEME" --activate --allow-root || echo "Theme setup skipped."
fi

exec "$@"