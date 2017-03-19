#!/bin/bash

if [[ ! -d /root/.ssh ]]; then
  mkdir /root/.ssh
fi

if [[ ! -f /root/.ssh/known_hosts ]]; then
  echo "Add github.com to root known_hosts."
  touch /root/.ssh/known_hosts && ssh-keyscan -H github.com >> /root/.ssh/known_hosts && chmod 600 /root/.ssh/known_hosts
else
  echo "github.com is already added to root known_hosts."
fi

if [[ ! -d ~/.ssh ]]; then
  mkdir ~/.ssh
fi

if [[ ! -f ~/.ssh/known_hosts ]]; then
  echo "Add github.com to known_hosts."
  touch ~/.ssh/known_hosts && ssh-keyscan -H github.com >> ~/.ssh/known_hosts && chmod 600 ~/.ssh/known_hosts
else
  echo "github.com is already added to known_hosts."
fi
