# Dotfiles

These dotfiles will install common software and setup preferences on a new Mac OS system.

## Some highlights

* Sets up VVV with some custom sites for things like plugin development
* Sets up Z shell that supports both Git and SVN
* Sets up some commands for common functionality
* Configures Mac OS defaults

## Included software / tools

* 1password
* ack
* Alfred
* AppCleaner
* bash-completion
* Bower
* Composer
* Cordova
* coreutils
* direnv
* Dropbox
* fabric
* Filezilla
* Genymotion
* gettext
* git (with configuration)
* gnupg
* go
* Google Chrome
* Google Cloud SDK (with configuration)
* Google Drive
* GPG Tools
* grc
* Grunt CLI
* Gulp CLI
* imagemagick
* Ionic CLI
* iTerm 2 (with configuration)
* Keybase
* Java
* Node
* OpenSSL
* Paw
* PHP
* PHPCodeSniffer (including WordPress Coding Standards and PHPCompatibility sniffs)
* PHPMD
* PHPUnit
* Sequel Pro
* Silverlight
* Skype
* Slack
* Spotify
* Sublime Text 3 (with configuration)
* Subversion
* TG Pro
* Tunnelblick
* UnRAR
* Vagrant (with some plugins)
* Varying Vagrant Vagrants (with configuration)
* Virtualbox
* VLC Player
* wget
* WP-CLI
* yarn
* zsh (with configuration)

## Usage

### Prerequisites

#### SSH Key

* Create an SSH key for GitHub: `ssh-keygen -t rsa -b 4096 -C "flixos90@gmail.com"`
* Store it as `~/.ssh/id_rsa`
* Run `eval "$(ssh-agent -s)"` and then `ssh-add ~/.ssh/id_rsa`
* Run `pbcopy < ~/.ssh/id_rsa`
* [Add the new key to your GitHub account](https://github.com/settings/keys) by pasting it

#### GPG Key

* Create a GPG key: `gpg --full-generate-key` (RSA and RSA, key length 4096)
* Run `gpg --list-secret-keys --keyid-format LONG` and copy the value behind the slash under `sec`
* Run `gpg --armor --export $KEY` where you paste the value instead of $KEY
* Copy the printed key to the clipboard
* [Add the new key to your GitHub account](https://github.com/settings/keys) by pasting it

### Setting up dotfiles

* place the repository at `$HOME/dotfiles`
* remove `git/gitconfig.local.symlink`
* adjust or remove the following files:
    * `bin/set-defaults`
    * `google-cloud-sdk/install.sh`
    * `iterm2/com.googlecode.iterm2.plist`
    * `vvv/gitconfig`
* run `script/bootstrap`
* run `script/install`

### Postrequisites

These are noted here for my own setup, they are not actually required as you will see.

* Add license key to Sublime Text 3
* Install Adobe Creative Suite CS6
* Install Microsoft Office 2011

## Credits

Most of my dotfiles are a collection of things I found in other people's dotfiles, and then sometimes tweaked it to my own needs.
A lot of them (especially the general infrastructure) were copied from [Jeremy Felt](https://github.com/jeremyfelt/dotfiles), and my dotfiles were also inspired by (in any way):

* [Helen Hou-Sandí](https://gist.github.com/helen/8493a6b4b57bfbf1ecaf)
* [Pascal Birchler](https://github.com/swissspidy/dotfiles)
* [John Blackbourn](https://johnblackbourn.com/my-st3-packages)
