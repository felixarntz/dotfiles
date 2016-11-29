#!/bin/bash

echo "Setting up buddypress.dev"

WP_PLUGINS=( buddypress )
GIT_PLUGINS=()

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS buddypress"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON buddypress.* TO wp@localhost IDENTIFIED BY 'wp';"

if [[ ! -d "htdocs" ]]; then
	noroot mkdir htdocs
	cd htdocs
	noroot wp core download --quiet
	noroot wp core config --dbname=buddypress --dbuser=wp --dbpass=wp --quiet --extra-php <<PHP
define('WP_DEBUG', true);
PHP
	noroot wp core install --url=buddypress.dev --quiet --title="BuddyPress Dev" --admin_name=admin --admin_email="admin@local.dev" --admin_password="password"
	noroot wp plugin uninstall akismet --quiet
	noroot wp plugin uninstall hello --quiet
	noroot wp comment delete 1 --force --quiet
	noroot wp post delete 1 --force --quiet
else
	cd htdocs
	noroot wp core update --quiet
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
