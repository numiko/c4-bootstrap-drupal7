#!/bin/bash
# configures drupal so that nginx can reverse proxy to it.

echo "    
    $conf['reverse_proxy'] = TRUE;
    $conf['reverse_proxy_addresses'] = array('127.0.0.1');
    $conf['page_cache_invoke_hooks'] = FALSE;
    " > /var/www/sites/default/setting.php

