if [ ! -f ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package ]; then
	curl "https://packagecontrol.io/Package Control.sublime-package" > ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package
fi

if [ ! -f ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Theme\ -\ Cobalt2.sublime-package ]; then
	cp ~/dotfiles/sublime-text-3/Theme\ -\ Cobalt2.sublime-package ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/
fi

if [ ! -f /usr/local/bin/subl ]; then
	ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
fi

if [ ! -d ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User ]; then
	mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
fi

ln -s ~/dotfiles/sublime-text-3/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
ln -s ~/dotfiles/sublime-text-3/Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings
ln -s ~/dotfiles/sublime-text-3/SublimeLinter.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/SublimeLinter.sublime-settings
ln -s ~/dotfiles/sublime-text-3/phpcs.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/phpcs.sublime-settings

ln -s ~/dotfiles/sublime-text-3/CSS.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/CSS.sublime-settings
ln -s ~/dotfiles/sublime-text-3/HTML.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/HTML.sublime-settings
ln -s ~/dotfiles/sublime-text-3/JavaScript\ \(Babel\).sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/JavaScript\ \(Babel\).sublime-settings
ln -s ~/dotfiles/sublime-text-3/JavaScript.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/JavaScript.sublime-settings
ln -s ~/dotfiles/sublime-text-3/JSON.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/JSON.sublime-settings
ln -s ~/dotfiles/sublime-text-3/LESS.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/LESS.sublime-settings
ln -s ~/dotfiles/sublime-text-3/PHP.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/PHP.sublime-settings
ln -s ~/dotfiles/sublime-text-3/Sass.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Sass.sublime-settings
