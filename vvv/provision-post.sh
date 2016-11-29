#!/bin/sh

# Only run installations/updates when we have a connection
#
# This code comes from the original VVV provisioning script.

function networkDetection() {
	if [[ "$(wget --tries=3 --timeout=5 --spider http://google.com 2>&1 | grep 'connected')" ]]; then
		ping_result="Connected"
	else
		ping_result="Not Connected"
	fi
}

function networkCheck() {
	networkDetection
	if [[ ! "$ping_result" == "Connected" ]]; then
		echo -e "\nNo network connection available, skipping package installation"
		exit 0
	fi
}

function setupGitConfig() {
	cp "/srv/config/custom/gitconfig" "/home/vagrant/.gitconfig"
	echo " * Copied /srv/config/gitconfig to /home/vagrant/.gitconfig"
}

function installNodeModules() {
	if [[ "$(gulp --version)" ]]; then
		echo "Updating Gulp CLI"
		npm update -g gulp-cli &>/dev/null
	else
		echo "Installing Gulp CLI"
		npm install -g gulp-cli &>/dev/null
	fi

	if [[ "$(bower --version)" ]]; then
		echo "Updating Bower"
		npm update -g bower &>/dev/null
	else
		echo "Installing Bower"
		npm install -g bower &>/dev/null
	fi
}

networkCheck

setupGitConfig
installNodeModules
