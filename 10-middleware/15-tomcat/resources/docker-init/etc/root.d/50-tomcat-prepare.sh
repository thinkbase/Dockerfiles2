#! /bin/bash
set -x
set -o nounset
set -o errexit

# Make u01 and tomcat the same group
if [[ "$(cat /docker-init/info/ENV_FIRST_BOOT)" == "true" ]]; then
	usermod u01 -aG tomcat
	usermod tomcat -aG u01
	
	chown -RL u01 /var/lib/tomcat9
fi
