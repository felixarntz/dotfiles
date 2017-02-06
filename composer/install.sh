if [ ! -x "$(command -v composer)" ]; then
	cd /tmp/
	curl -sS https://getcomposer.org/installer | php
	chmod +x composer.phar
	mv composer.phar /usr/local/bin/composer
else
	composer self-update
fi

if [ ! -d ~/.composer ]; then
	mkdir ~/.composer
fi

if [ ! -d ~/.composer/vendor ]; then
	ln -s ~/dotfiles/composer/composer.json ~/.composer/composer.json
	composer global install
else
	composer global update
fi
