#!/bin/sh

cd ~/dotfiles/vvv
VVV_ROOT=$(pwd -P)

if [ ! -d "~/Development" ]; then
	mkdir -p ~/Development
fi

cd ~/Development

# Clone VVV
if [ ! -d "vvv" ]; then
	git clone git@github.com:Varying-Vagrant-Vagrants/VVV.git vvv
	ln -s $VVV_ROOT/vvv-custom.yml vvv/vvv-custom.yml
	ln -s $VVV_ROOT/Customfile vvv/Customfile
	ln -s $VVV_ROOT/config/gitconfig vvv/config/gitconfig
	ln -s $VVV_ROOT/config/init/vvv-start-custom.conf vvv/config/init/vvv-start-custom.conf
	ln -s $VVV_ROOT/provision/provision-post.sh vvv/provision/provision-post.sh

	if [ -f "$VVV_ROOT/provision/github.token" ]; then
		ln -s $VVV_ROOT/provision/github.token vvv/provision/github.token
	fi

	if [ ! -d "vvv/www/api-api-develop" ]; then
		mkdir -p vvv/www/api-api-develop
	fi

	ln -s $VVV_ROOT/www/api-api-develop/vvv-hosts vvv/www/api-api-develop/vvv-hosts
	ln -s $VVV_ROOT/www/api-api-develop/vvv-init.sh vvv/www/api-api-develop/vvv-init.sh
	ln -s $VVV_ROOT/www/api-api-develop/vvv-nginx.conf vvv/www/api-api-develop/vvv-nginx.conf

	if [ ! -d "vvv/www/playground" ]; then
		mkdir -p vvv/www/playground
	fi

	ln -s $VVV_ROOT/www/playground/vvv-hosts vvv/www/playground/vvv-hosts
	ln -s $VVV_ROOT/www/playground/vvv-nginx.conf vvv/www/playground/vvv-nginx.conf
else
	cd vvv
	git pull
	cd ..
fi

# Clone misc repositories into misc directory (not VVV-related)
MISC_REPOSITORIES=( custom-site-template leavesandlove-wp-plugin-util plugin-lib slides vvv-custom-utilities wp-background-processing-ui wp-js wp-map-picker wp-media-picker wp-starter-theme wpdlib )
for i in "${MISC_REPOSITORIES[@]}"
do :
	if [[ ! -d "misc/$i" ]]; then
		git clone git@github.com:felixarntz/$i.git misc/$i
	else
		cd misc/$i
		git pull
		cd ..
	fi
done
