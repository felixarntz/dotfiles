if [ ! -x "$(command -v composer)" ]; then
	cd /tmp/
	curl -sS https://getcomposer.org/installer | php
	chmod +x composer.phar
	mv composer.phar /usr/local/bin/composer
else
	composer self-update
fi
