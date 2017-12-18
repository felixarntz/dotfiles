#!/bin/sh

cd ~/dotfiles/vvv
VVV_ROOT=$(pwd -P)

if [ ! -d "~/Development" ]; then
	mkdir -p ~/Development
fi

cd ~/Development

# Clone VVV
if [ ! -d "vvv" ]; then
	git clone git@github.com:felixarntz/VVV.git vvv

	cd vvv
	git remote add upstream git@github.com:Varying-Vagrant-Vagrants/VVV.git
	cd ..

	#ln -s $VVV_ROOT/vvv-custom.yml vvv/vvv-custom.yml
	cp "$VVV_ROOT/vvv-custom.yml" vvv
	#ln -s $VVV_ROOT/Customfile vvv/Customfile
	cp $VVV_ROOT/Customfile vvv
	#ln -s $VVV_ROOT/config/gitconfig vvv/config/gitconfig
	cp $VVV_ROOT/config/gitconfig vvv/config
	#ln -s $VVV_ROOT/config/init/vvv-start-custom.conf vvv/config/init/vvv-start-custom.conf
	cp $VVV_ROOT/config/init/vvv-start-custom.conf vvv/config/init
	#ln -s $VVV_ROOT/provision/provision-pre.sh vvv/provision/provision-pre.sh
	cp $VVV_ROOT/provision/provision-pre.sh vvv/provision
	#ln -s $VVV_ROOT/provision/provision-post.sh vvv/provision/provision-post.sh
	cp $VVV_ROOT/provision/provision-post.sh vvv/provision

	if [ -f "$VVV_ROOT/provision/github.token" ]; then
		#ln -s $VVV_ROOT/provision/github.token vvv/provision/github.token
		cp $VVV_ROOT/provision/github.token vvv/provision
	fi

	if [ ! -d "vvv/www/playground" ]; then
		mkdir -p vvv/www/playground
	fi

	#ln -s $VVV_ROOT/www/playground/vvv-hosts vvv/www/playground/vvv-hosts
	#ln -s $VVV_ROOT/www/playground/vvv-nginx.conf vvv/www/playground/vvv-nginx.conf
	cp $VVV_ROOT/www/playground/vvv-hosts vvv/www/playground
	cp $VVV_ROOT/www/playground/vvv-nginx.conf vvv/www/playground
else
	cd vvv
	git pull
	cd ..
fi

# Clone misc repositories into misc directory (not VVV-related)
MISC_REPOSITORIES=( custom-site-template plugin-lib slides vvv vvv-custom-utilities vvv-wordpress-develop wp-background-processing-ui wp-map-picker wp-media-picker )
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
