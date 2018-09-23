#!/bin/sh
#
# Google Cloud SDK
#

gcloud init --console-only
gcloud config set core/account hello@felix-arntz.me
gcloud config set core/disable_usage_reporting True
gcloud config set core/project leaves-and-love-network
gcloud config set compute/region us-east1
gcloud config set compute/zone us-east1-b
