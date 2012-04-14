#!/bin/bash

# Install Drupal if the /var/www/ directory is empty

DIR="/var/www/"
VERSION="7.12"

if [ -f ${DIR} ]; then
    echo "Already Restored old site"
else
    echo "Installing fresh Drupal"
    ## Install wget so we can download the latest wordpress
    apt-get install wget
    ## Grab drupal
    cd ${DIR}
    wget http://ftp.drupal.org/files/projects/drupal-${VERSION}.tar.gz
    ## Extract files
    tar xvfz drupal-${VERSION}.tar.gz -C ${DIR}
    ## Standardise directory name
    mv drupal-${VERSION} drupal
fi
