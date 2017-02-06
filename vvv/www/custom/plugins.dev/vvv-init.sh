#!/bin/bash

echo "Setting up plugins.dev"

WP_PLUGINS=( contact-form-7 )
GIT_PLUGINS=( attachment-taxonomies bootstrap-for-contact-form-7 bulk-emails content-organizer custom-css-outsourcer customizer-definitely easy-digital-downloads options-definitely paypal-plus-for-edd pet-store post-types-definitely responsive-video-shortcodes site-icon-extended torro-forms-bootstrap-markup widgets-definitely wordpress-fields-api wp-encrypt wp-gcs-offload wp-plugin-control wp-shortcode-cache )

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS plugins"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON plugins.* TO wp@localhost IDENTIFIED BY 'wp';"

if [[ ! -d "htdocs" ]]; then
	noroot mkdir htdocs
	cd htdocs
	noroot wp core download --quiet
	noroot wp core config --dbname=plugins --dbuser=wp --dbpass=wp --quiet --extra-php <<PHP
define('WP_DEBUG', true);
PHP
	noroot wp core install --url=plugins.dev --quiet --title="Plugins Dev" --admin_name=admin --admin_email="admin@local.dev" --admin_password="password"
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

if [[ ! -d "wp-content/plugins/torro-forms" ]]; then
	noroot git clone git@github.com:awsmug/torro-forms.git wp-content/plugins/torro-forms --quiet
else
	cd wp-content/plugins/torro-forms
	noroot git pull --quiet
	cd ../../..
fi
