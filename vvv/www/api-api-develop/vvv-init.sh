#!/usr/bin/env bash

REPO_NAMES=`cat ${VVV_CONFIG} | shyaml get-values sites.${SITE_ESCAPED}.custom.repo_names 2> /dev/null`

for i in "${REPO_NAMES[@]}"
do :
  if [[ ! -d "${VVV_PATH_TO_SITE}/$i" ]]; then
    noroot git clone https://github.com:api-api/$i.git ${VVV_PATH_TO_SITE}/$i
  else
    cd ${VVV_PATH_TO_SITE}/$i
    noroot git pull
  fi
done
