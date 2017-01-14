#!/bin/bash

echo "Setting up network-revolution.dev"

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS network_revolution"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON network_revolution.* TO wp@localhost IDENTIFIED BY 'wp';"

if [[ ! -d "htdocs" ]]; then
	noroot mkdir htdocs
	cd htdocs
	noroot wp core download --quiet
	noroot wp core config --dbname=network_revolution --dbuser=wp --dbpass=wp --quiet --extra-php <<PHP
define('WP_DEBUG', true);
PHP
	noroot wp core multisite-install --url=network-revolution.dev --subdomains --quiet --title="Network Revolution" --admin_name=admin --admin_email="admin@local.dev" --admin_password="password"
	noroot wp plugin uninstall hello --url=network-revolution.dev --quiet
	noroot wp comment delete 1 --force --url=network-revolution.dev --quiet
	noroot wp post delete 1 --force --url=network-revolution.dev --quiet
else
	cd htdocs
	noroot wp core update --url=network-revolution.dev --quiet
fi

if [[ ! -d "wp-content/plugins/wp-multi-network" ]]; then
	noroot git clone git@github.com:felixarntz/wp-multi-network.git wp-content/plugins/wp-multi-network --quiet
	noroot wp plugin activate wp-multi-network --network --url=network-revolution.dev --quiet

	noroot wp site create --slug=subsite1 --title="Subsite 1" --email="admin@local.dev" --network_id=1 --url=network-revolution.dev --quiet
	noroot wp site create --slug=subsite2 --title="Subsite 2" --email="admin@local.dev" --network_id=1 --url=network-revolution.dev --quiet
	noroot wp wp-multi-network create network-revolution2.dev / --site_name="Network Revolution 2" --user=1 --url=network-revolution.dev --quiet
	noroot wp site create --slug=subsite1 --title="Subsite 1" --email="admin@local.dev" --network_id=2 --url=network-revolution2.dev --quiet
	noroot wp site create --slug=subsite2 --title="Subsite 2" --email="admin@local.dev" --network_id=2 --url=network-revolution2.dev --quiet
else
	cd wp-content/plugins/wp-multi-network
	noroot git pull --quiet
	cd ../../..
fi

if [[ ! -d "wp-content/mu-plugins" ]]; then
	noroot git clone git@github.com:felixarntz/wp-network-roles.git wp-content/mu-plugins --quiet
else
	cd wp-content/mu-plugins
	noroot git pull --quiet
	cd ../../..
fi

if [[ ! -d "wp-content/plugins/global-admin" ]]; then
	noroot git clone git@github.com:felixarntz/global-admin.git wp-content/plugins/global-admin --quiet
	noroot wp plugin activate global-admin --network --url=network-revolution.dev --quiet
else
	cd wp-content/plugins/global-admin
	noroot git pull --quiet
	cd ../../..
fi
