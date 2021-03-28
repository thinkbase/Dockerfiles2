#! /bin/bash
set -x
set -o nounset
set -o errexit

# Make u01 and tomcat the same group
usermod u01 -aG tomcat
usermod tomcat -aG u01

#start apache2 (ref: /lib/systemd/system/tomcat9.service)
export CATALINA_HOME=/usr/share/tomcat9
export CATALINA_BASE=/var/lib/tomcat9
export CATALINA_TMPDIR=/tmp
export JAVA_OPTS=-Djava.awt.headless=true
/usr/libexec/tomcat9/tomcat-update-policy.sh
/usr/libexec/tomcat9/tomcat-start.sh
