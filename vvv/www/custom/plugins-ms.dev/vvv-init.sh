#!/bin/bash

echo "Setting up plugins-ms.dev"

WP_PLUGINS=()
GIT_PLUGINS=( wp-encrypt wp-gcs-offload wp-plugin-control )

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS plugins_ms"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON plugins_ms.* TO wp@localhost IDENTIFIED BY 'wp';"

if [[ ! -d "htdocs" ]]; then
	noroot mkdir htdocs
	cd htdocs
	noroot wp core download --quiet
	noroot wp core config --dbname=plugins_ms --dbuser=wp --dbpass=wp --quiet --extra-php <<PHP
define('WP_DEBUG', true);
PHP
	noroot wp core multisite-install --url=plugins-ms.dev --subdomains --quiet --title="Plugins MS Dev" --admin_name=admin --admin_email="admin@local.dev" --admin_password="password"
	noroot wp plugin uninstall akismet --url=plugins-ms.dev --quiet
	noroot wp plugin uninstall hello --url=plugins-ms.dev --quiet
	noroot wp comment delete 1 --force --url=plugins-ms.dev --quiet
	noroot wp post delete 1 --force --url=plugins-ms.dev --quiet
	noroot wp site create --slug=subsite1 --title="Subsite 1" --email="admin@local.dev" --url=plugins-ms.dev --quiet
	noroot wp site create --slug=subsite2 --title="Subsite 2" --email="admin@local.dev" --url=plugins-ms.dev --quiet
else
	cd htdocs
	noroot wp core update --url=plugins-ms.dev --quiet
fi

for i in "${WP_PLUGINS[@]}"
do :
	if [[ ! -d "wp-content/plugins/$i" ]]; then
		noroot wp plugin install $i --quiet
	else
		noroot wp plugin update $i --quiet
	fi
done

for j in "${GIT_PLUGINS[@]}"
do :
	if [[ ! -d "wp-content/plugins/$j" ]]; then
		noroot git clone git@github.com:felixarntz/$j.git wp-content/plugins/$j --quiet
	else
		cd wp-content/plugins/$j
		noroot git pull --quiet
		cd ../../..
	fi
done
