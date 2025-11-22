#!/bin/bash

# 1. Check if WordPress is already installed
if [ -f ./wp-config.php ]; then
    echo "WordPress is already installed."
else
    # 2. Download WP-CLI (If not present)
    if [ ! -f /usr/local/bin/wp ]; then
        echo "Downloading WP-CLI..."
        wget -O wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        chmod +x wp-cli.phar
        mv wp-cli.phar /usr/local/bin/wp
    fi

    # 3. Download Core Files
    # '|| true' prevents crash if files are already there
    wp core download --allow-root || true

    # 4. Create Config & Wait for DB
    # We loop this step because 'wp config create' crashes if the DB is not reachable yet.
    echo "Waiting for MariaDB to become reachable..."
    
    # Force delete just in case a previous run left a broken file
    rm -f wp-config.php

    # Keep trying to create the config until it works (which means DB is up)
    until wp config create \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASS \
        --dbhost=$DB_HOST \
        --allow-root; do
        
        echo "MariaDB is not ready (Connection Refused). Retrying in 5 seconds..."
        rm -f wp-config.php # Delete partial file if created
        sleep 5
    done
    
    echo "Connected to MariaDB and Config created!"

    # 5. Install WordPress
    wp core install \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --skip-email \
        --allow-root

    wp user create $WP_USER $WP_USER_EMAIL \
        --role=author \
        --user_pass=$WP_USER_PASSWORD \
        --allow-root
fi

chown -R www-data:www-data /var/www/html
exec /usr/sbin/php-fpm8.2 -F