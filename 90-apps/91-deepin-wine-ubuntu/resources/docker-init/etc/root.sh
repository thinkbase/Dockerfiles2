#! /bin/bash
set -x
set -o nounset
set -o errexit

echo "deepin-wine-ubuntu 容器, 应用日志文件: /tmp/deepinwine.log ..."
ls -al /opt/deepinwine/apps > /tmp/deepinwine.log
echo -e "\n可用应用(/usr/local/bin 目录):" >> /tmp/deepinwine.log
ls -al /usr/local/bin >> /tmp/deepinwine.log
echo -e "================\n" >> /tmp/deepinwine.log

tail -f /tmp/deepinwine.log
