#!/bin/bash

#!/bin/bash

echo "Setting up pet-shelter.dev"

mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS pet_shelter"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON pet_shelter.* TO wp@localhost IDENTIFIED BY 'wp';"

if [[ ! -d "htdocs" ]]; then
	noroot git clone git@github.com:pet-shelter/project.git htdocs --quiet
	mv .env htdocs/.env
	cd htdocs
	noroot composer install --quiet
	cd web/app/themes/pet-shelter-theme
	noroot composer install --quiet
	#cd ../../plugins/pet-shelter
	#noroot composer install --quiet
	cd ../../../..
	noroot wp core multisite-install --subdomains --url=pet-shelter.dev --quiet --title="Pet Shelter" --admin_name=admin --admin_email="admin@local.dev" --admin_password="password"
	noroot wp comment delete 1 --force --url=pet-shelter.dev --quiet
	noroot wp post delete 1 --force --url=pet-shelter.dev --quiet
else
	cd htdocs
	noroot git pull --quiet
	noroot composer update --quiet
	cd web/app/plugins/pet-shelter
	noroot composer update --quiet
	cd ../../themes/pet-shelter-theme
	noroot composer update --quiet
	cd ../../../..
fi
