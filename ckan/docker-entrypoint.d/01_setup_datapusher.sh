#!/bin/bash

if [[ $CKAN__PLUGINS == *"datapusher"* ]]; then
   # Datapusher settings have been configured in the .env file
   # Set API token if necessary
   if [ -z "$CKAN__DATAPUSHER__API_TOKEN" ] ; then
      echo "Set up ckan.datapusher.api_token in the CKAN config file"
      ckan config-tool $CKAN_INI "ckan.datapusher.api_token=$(ckan -c $CKAN_INI user token add ckan_admin datapusher | tail -n 1 | tr -d '\t')"
   fi
else
   echo "Not configuring DataPusher"
fi
if [[ $CKAN__PLUGINS == *"xloader"* ]]; then
   # Xloader settings have been configured in the .env file
   # Set API token if necessary
   if [ -z "$CKAN__XLOADER__API_TOKEN" ] ; then
      echo "Set up ckanext.xloader.api_token in the CKAN config file"
      ckan config-tool $CKAN_INI "ckanext.xloader.api_token=$(ckan -c $CKAN_INI user token add ckan_admin xloader | tail -n 1 | tr -d '\t')"
   fi
else
   echo "Not configuring Xloader"