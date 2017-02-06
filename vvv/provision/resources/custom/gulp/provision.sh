#!/bin/bash

if [[ "$(gulp --version)" ]]; then
	echo "Updating Gulp CLI"
	npm update -g gulp-cli &>/dev/null
else
	echo "Installing Gulp CLI"
	npm install -g gulp-cli &>/dev/null
fi
