#! /bin/bash
set -x
set -o nounset
set -o errexit

#start tomcat (ref: /lib/systemd/system/tomcat9.service)
/usr/libexec/tomcat9/tomcat-update-policy.sh
nohup /usr/libexec/tomcat9/tomcat-start.sh > ${RT_CONSOLE_LOG_PREFIX}tomcat.log &
