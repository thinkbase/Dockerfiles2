#! /bin/bash
set -x
set -o nounset
set -o errexit

# Make u01 and www-data the same group
usermod u01 -aG www-data
usermod www-data -aG u01

#start apache2
/usr/sbin/apache2ctl -D FOREGROUND
