#!/bin/bash

if [[ ! -d /root/.ssh ]]; then
  mkdir /root/.ssh
fi

if [[ ! -f /root/.ssh/known_hosts ]]; then
  echo "Add github.com to known_hosts."
  touch /root/.ssh/known_hosts && ssh-keyscan -H github.com >> /root/.ssh/known_hosts && chmod 600 /root/.ssh/known_hosts
else
  echo "github.com is already added to known_hosts."
fi
