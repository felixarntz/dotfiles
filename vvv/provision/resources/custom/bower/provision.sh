#!/bin/bash

if [[ "$(bower --version)" ]]; then
	echo "Updating Bower"
	npm update -g bower &>/dev/null
else
	echo "Installing Bower"
	npm install -g bower &>/dev/null
fi
