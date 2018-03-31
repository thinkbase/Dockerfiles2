#! /bin/bash
set -x
set -o nounset
set -o errexit

# Make u01 and www-data the same group
usermod u01 -aG www-data
usermod www-data -aG u01

# Make ${LATEST_PHP_INI} the latest ini for php.ini
if [ -f "${LATEST_PHP_INI}" ]
then
    ln -s "${LATEST_PHP_INI}" /etc/php/7.0/apache2/conf.d/99-latest-php.ini
fi

#start apache2
/usr/sbin/apache2ctl -D FOREGROUND
