if [ ! -x "$(command -v phpunit)" ]; then
	cd /tmp/
	wget https://phar.phpunit.de/phpunit.phar
	chmod +x phpunit.phar
	mv phpunit.phar /usr/local/bin/phpunit
else
	phpunit --self-upgrade
fi
