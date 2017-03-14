#!/bin/sh

APT_PACKAGE_CUSTOM_LIST=( redis-server php7.0-redis )

not_installed() {
  dpkg -s "$1" 2>&1 | grep -q 'Version:'
  if [[ "$?" -eq 0 ]]; then
    apt-cache policy "$1" | grep 'Installed: (none)'
    return "$?"
  else
    return 0
  fi
}

for pkg in "${APT_PACKAGE_CUSTOM_LIST[@]}"; do
	if not_installed "${pkg}"; then
		apt-get -y update
		apt-get -y install ${pkg}
		echo " * Installed apt-get package ${pkg}"
	fi
done

cp "/srv/config/custom/init/vvv-start-custom.conf" "/etc/init/vvv-start-custom.conf"
echo " * Copied /srv/config/custom/init/vvv-start-custom.conf to /etc/init/vvv-start-custom.conf"

cp "/srv/config/custom/gitconfig" "/home/vagrant/.gitconfig"
echo " * Copied /srv/config/custom/gitconfig to /home/vagrant/.gitconfig"
