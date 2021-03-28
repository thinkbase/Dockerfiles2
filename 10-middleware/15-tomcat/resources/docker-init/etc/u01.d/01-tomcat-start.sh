#! /bin/bash
set -x
set -o nounset
set -o errexit

#start tomcat (ref: /lib/systemd/system/tomcat9.service)
/usr/libexec/tomcat9/tomcat-update-policy.sh
nohup /usr/libexec/tomcat9/tomcat-start.sh 1 > /tmp/tomcat.log 2>&1 &
tail -f /tmp/tomcat.log
