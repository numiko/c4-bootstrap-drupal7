#!/bin/bash

if [ ! -f /var/www/drupal/sites/default/settings.php ]
then
cp /var/www/drupal/sites/default/default.settings.php /var/www/drupal/sites/default/settings.php

# generate new password
passwd=`pwgen 10 1`
else
# use existing password
passwd=`cat /var/www/drupal/sites/default/settings.php | grep DB_PASSWORD | awk -F "'" '{print $4}'`
fi

## Set up permissions

chmod a+w /var/www/drupal/sites/default/settings.php
chmod a+w /var/www/drupal/sites/default

## Set password in config file

new_array="\$databases = array (
  'default' =>
  array (
    'default' =>
    array (
      'database' => 'bootstrapdrupal',
      'username' => 'bootstrap_user',
      'password' => '$passwd',
      'host' => 'localhost',
      'port' => '',
      'driver' => 'mysql',
      'prefix' => '',
    ),
  ),
);"

sed -i s/TESTING/"`echo $new_array`"/ /var/www/drupal/sites/default/settings.php

# set the db up

mysqladmin -u root create bootstrapdrupal
mysql -u root -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES ON bootstrapdrupal.* TO bootstrap_user@'localhost' IDENTIFIED BY '${passwd}'";
mysqladmin -u root flush-privileges

## restore old DB if alvailable

if [ -f /var/tmp/sql/00-bootstrapdrupal.sql ];
then
    mysql -u root -D bootstrapwp < /var/tmp/sql/00-bootstrapdrupal.sql
fi

