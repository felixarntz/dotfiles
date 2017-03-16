#!/bin/sh

not_installed() {
  dpkg -s "$1" 2>&1 | grep -q 'Version:'
  if [[ "$?" -eq 0 ]]; then
    apt-cache policy "$1" | grep 'Installed: (none)'
    return "$?"
  else
    return 0
  fi
}

if not_installed redis-server; then
	apt-get -y update
	apt-get -y install redis-server
	echo " * Installed apt-get package redis-server"
fi

if not_installed php7.0-redis; then
	apt-get -y update
	apt-get -y install php7.0-redis
	echo " * Installed apt-get package php7.0-redis"
fi

cp "/srv/config/init/vvv-start-custom.conf" "/etc/init/vvv-start-custom.conf"
echo " * Copied /srv/config/init/vvv-start-custom.conf to /etc/init/vvv-start-custom.conf"

cp "/srv/config/gitconfig" "/home/vagrant/.gitconfig"
echo " * Copied /srv/config/gitconfig to /home/vagrant/.gitconfig"
