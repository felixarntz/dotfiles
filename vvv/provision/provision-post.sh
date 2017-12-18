#!/bin/bash

not_installed() {
	dpkg -s "$1" 2>&1 | grep -q 'Version:'
	if [[ "$?" -eq 0 ]]; then
		apt-cache policy "$1" | grep 'Installed: (none)'
		return "$?"
	else
		return 0
	fi
}

apt_package_custom_list=( redis-server php7.0-redis )

for pkg in "${apt_package_check_list[@]}"; do
	if not_installed "${pkg}"; then
		apt-get -y update
		apt-get -y install "${pkg}"
		echo " * Installed apt-get package ${pkg}"
	fi
done

if [ ! -f "/etc/init/vvv-start-custom.conf" ]; then
	cp "/srv/config/init/vvv-start-custom.conf" "/etc/init/vvv-start-custom.conf"
	echo " * Copied /srv/config/init/vvv-start-custom.conf to /etc/init/vvv-start-custom.conf"
fi

if [ ! -f "/home/vagrant/.gitconfig" ]; then
	cp "/srv/config/gitconfig" "/home/vagrant/.gitconfig"
	echo " * Copied /srv/config/gitconfig to /home/vagrant/.gitconfig"
fi
