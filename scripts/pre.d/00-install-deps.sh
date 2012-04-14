#!/bin/bash

# Sample file that installs your dependancies on launch

apt-get update

echo "installing apache and php5"
apt-get install -y apache2 php5 php5-gd php5-mysql php-apc php5-memcached

## Stop apache from running so we can configure it

/etc/init.d/apache2 stop

## Clean /var/www/ directory

rm -Rf /var/www/*

## Install nginx for our caching layer

echo "installing nginx"
apt-get install -y nginx

## Stop Nginx ready for configuration

/etc/init.d/nginx stop

## Install MySQL server

echo "installing mysql-server"
apt-get -y install pwgen
# Generate a strong password for the mysql service, using /dev/urandom
 password=`pwgen -s 20 1`

#store for use in the install script
 echo mysql-server-5.5 mysql-server/root_password password $password | debconf-set-selections
 echo mysql-server-5.5 mysql-server/root_password_again password $password | debconf-set-selections

 echo "mysql-server settings preseeded, now installing via apt-get"
 DEBIAN_FRONTEND=noninteractive apt-get -y install -qq mysql-server

## Fix mysql password for root

mysqladmin -u root password ${password}

sed -i "s/\[client\]/\[client\]\npassword        = ${password}/" /etc/mysql/my.cnf

## Install Memcached

echo "installing memcached"
apt-get install -y memcached
