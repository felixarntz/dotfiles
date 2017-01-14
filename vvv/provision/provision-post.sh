#!/bin/sh

# Only run installations/updates when we have a connection
#
# This code comes from the original VVV provisioning script.

cp "/srv/config/custom/gitconfig" "/home/vagrant/.gitconfig"
echo " * Copied /srv/config/gitconfig to /home/vagrant/.gitconfig"
