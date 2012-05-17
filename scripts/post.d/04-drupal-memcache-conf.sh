#!/bin/bash
# configures drupal to use memcached

mkdir -p /var/www/sites/all/modules/drupal.org

wget -O /tmp/memcached.tgz http://ftp.drupal.org/files/projects/memcache-7.x-1.0.tar.gz

tar xvfz /tmp/memcached.tgz -C /var/www/sites/all/modules/drupal.org/

echo "    
    $conf['cache_backends'][] = 'sites/all/modules/drupal.org/memcache/memcache.inc';
    $conf['cache_default_class'] = 'MemCacheDrupal';
    // The 'cache_form' bin must be assigned no non-volatile storage.
    $conf['cache_class_cache_form'] = 'DrupalDatabaseCache';

    $conf['memcache_servers'] = array(
            '127.0.0.1:11211' => 'default',
	    );
    " > /var/www/sites/default/setting.php

