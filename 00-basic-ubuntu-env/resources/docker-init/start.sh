#!/bin/bash
#set -x
set -u

# 检查并增加工作用户(永远是 u01)
grep "\:${RT_WORKER_GID}\:" /etc/group
if [ $? -ne 0 ]
then
	groupadd -f -g ${RT_WORKER_GID} u01
fi
grep "^u01" /etc/passwd
if [ $? -ne 0 ]
then
	echo "useradd - u01 (${RT_WORKER_GID}:${RT_WORKER_UID}) ..."
	useradd -m -u ${RT_WORKER_UID} -g ${RT_WORKER_GID} -d /home/u01 -s /bin/bash u01
	echo "u01:docker.io" | chpasswd  # Can't set password properly with "-p" argument in "useradd" command
	usermod -a -G sudo u01
	# 标识为第一次启动
	echo "true" > /docker-init/info/ENV_FIRST_BOOT
else
	echo "false" > /docker-init/info/ENV_FIRST_BOOT
fi

# 准备 - 以 u01 的身份执行命令指定命令
echo "********************************************************************************"
echo "[$(date +%Y%m%d-%H%M%S)] >>> Prepare (as u01) [${RT_WORK_COMMAND}] ..."
echo "********************************************************************************"
echo "${RT_WORK_COMMAND}" > /docker-init/etc/u01.d/ZZ-RT_WORK_COMMAND.sh

# 执行初始化命令
echo "[$(date +%Y%m%d-%H%M%S)] >>> Begin to run (as root) [/docker-init/etc/root.sh] ..."
/docker-init/etc/root.sh
echo "[$(date +%Y%m%d-%H%M%S)] >>> Begin to run (as u01) [/docker-init/etc/u01.sh] ..."
sudo -u u01 "/docker-init/etc/u01.sh"
