#!/bin/bash

echo "Setting up leaves-and-love.dev"

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS leaves_and_love"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON leaves_and_love.* TO wp@localhost IDENTIFIED BY 'wp';"

if [[ ! -d "htdocs" ]]; then
	noroot git clone git@github.com:felixarntz/leaves-and-love-network.git htdocs --quiet
	mv .env htdocs/.env
	cd htdocs
	noroot composer install --quiet
	noroot wp core multisite-install --subdomains --url=leaves-and-love.dev --quiet --title="leaves-and-love.net" --admin_name=admin --admin_email="admin@local.dev" --admin_password="password"
	noroot wp comment delete 1 --force --url=leaves-and-love.dev --quiet
	noroot wp post delete 1 --force --url=leaves-and-love.dev --quiet
	noroot wp plugin activate wp-multi-network --network --url=leaves-and-love.dev --quiet
	noroot wp wp-multi-network create vielleichtinteressant.dev / --site_name="Vielleicht Interessant" --user=1 --url=leaves-and-love.dev --quiet
else
	cd htdocs
	noroot git pull --quiet
	noroot composer update --quiet
fi
