#!/bin/bash

echo "Setting up screen-reader-check.dev"

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS screen_reader_check"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON screen_reader_check.* TO wp@localhost IDENTIFIED BY 'wp';"

if [[ ! -d "htdocs" ]]; then
	noroot mkdir htdocs
	cd htdocs
	noroot wp core download --quiet
	noroot wp core config --dbname=screen_reader_check --dbuser=wp --dbpass=wp --quiet --extra-php <<PHP
define('WP_DEBUG', true);
PHP
	noroot wp core install --url=screen-reader-check.dev --quiet --title="Screen Reader Check" --admin_name=admin --admin_email="admin@local.dev" --admin_password="password"
	noroot wp plugin uninstall akismet --quiet
	noroot wp plugin uninstall hello --quiet
	noroot wp comment delete 1 --force --quiet
	noroot wp post delete 1 --force --quiet
else
	cd htdocs
	noroot wp core update --quiet
fi

if [[ ! -d "wp-content/plugins/screen-reader-check" ]]; then
	noroot git clone git@github.com:felixarntz/screen-reader-check.git wp-content/plugins/screen-reader-check --quiet
	cd wp-content/plugins/screen-reader-check
	noroot composer install --quiet
	cd ../../..
	noroot wp plugin activate screen-reader-check --quiet
else
	cd wp-content/plugins/screen-reader-check
	noroot git pull --quiet
	cd ../../..
fi

if [[ ! -d "wp-content/themes/screen-reader-check-theme" ]]; then
	noroot git clone git@github.com:felixarntz/screen-reader-check-theme.git wp-content/themes/screen-reader-check-theme --quiet
	noroot wp theme activate screen-reader-check-theme --quiet
else
	cd wp-content/themes/screen-reader-check-theme
	noroot git pull --quiet
	cd ../../..
fi
