#!/bin/bash

echo "Setting up playground.dev"

cd htdocs

cd api-api
if [[ ! -d "project" ]]; then
	noroot git clone git@github.com:awsmug/api-api.git project --quiet
	cd project
	noroot composer install --quiet
	cd ..
else
	cd project
	noroot git pull --quiet
	noroot composer update --quiet
	cd ..
fi
cd ..
