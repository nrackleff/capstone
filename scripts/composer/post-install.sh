#!/bin/sh

# Prepare the settings file for installation
if [ ! -f web/sites/default/settings.php ]
  then
    cp web/sites/default/default.settings.php web/sites/default/settings.php
    chmod 777 web/sites/default/settings.php
fi

# Prepare the services file for installation
if [ ! -f web/sites/default/services.yml ]
  then
    cp web/sites/default/default.services.yml web/sites/default/services.yml
    chmod 777 web/sites/default/services.yml
fi

# Prepare the files directory for installation
if [ ! -d web/sites/default/files ]
  then
    mkdir -m777 web/sites/default/files
fi

cd web;drush si --site-name="capstone" --db-url=mysql://root:root@localhost/capstone -y;cd ../

chmod 777 web/sites/default/s*

#Prepare the custom sync directory, which will sit outside of the web root
if [ ! -d configs ]
  then mkdir -m777 configs
fi
echo "\$config_directories['sync'] = '../configs';" >> web/sites/default/settings.php
echo "\$settings['trusted_host_patterns'] = array('capstone\.dev$',);" >> web/sites/default/settings.php
chmod 444 web/sites/default/s*
chmod -R 777 web/sites/default/files
