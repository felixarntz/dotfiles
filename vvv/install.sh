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
	cp "$VVV_ROOT/provision-post.sh" vvv/provision
	if [ -f "$VVV_ROOT/github.token" ]; then
		cp "$VVV_ROOT/github.token" vvv/provision
	fi
	mkdir -p vvv/config/custom
	cp "$VVV_ROOT/vvv/gitconfig" vvv/config/custom
	cp -R "$VVV_ROOT/vvv/custom" vvv/www
else
	cd vvv
	git pull
	cd ..
fi

# Clone WordPress Meta Environment into VVV
if [ ! -d "vvv/www/wordpress-meta-environment" ]; then
	git clone git@github.com:WordPress/meta-environment.git vvv/www/wordpress-meta-environment
else
	cd vvv/www/wordpress-meta-environment
	git pull
	cd ../../..
fi

# Clone misc repositories into VVV
MISC_REPOSITORIES=( bedrock leavesandlove-wp-plugin-util plugin-lib slides wp-background-processing-ui wp-js wp-map-picker wp-media-picker wp-objects wp-starter-theme wpdlib )
for i in "${MISC_REPOSITORIES[@]}"
do :
	if [[ ! -d "vvv/www/custom/misc/$i" ]]; then
		git clone git@github.com:felixarntz/$i.git vvv/www/custom/misc/$i
	else
		cd vvv/www/custom/misc/$i
		git pull
		cd ../../../..
	fi
done
