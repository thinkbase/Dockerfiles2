# thinkbase.net/mysql: 在 Ubuntu 的基础上安装 mysql 服务器
#  - 1.1 - 切换执行初始化SQL(MYSQL_INIT_SQL)的实现方法，支持类似 source 等 mysql 终端语句
#  - 1.0 - 初始版本
#
# 构造 image:
#   docker build --force-rm -t thinkbase.net/mysql:1.1 .
# 正常运行/启动(注意合理的参数: -p、-v、--env、--name):
#   docker run -d -p 3306:3306 -v /tmp/test-mysql:/data --name test-mysql thinkbase.net/mysql:1.1
#   docker run -d -p 3306:3306 -v /tmp/test-mysql:/data \
#              --env MYSQL_ROOT_PWD=changeme --name test-mysql thinkbase.net/mysql:1.1
#   docker run -d -p 3306:3306 -v /tmp/test-mysql:/data \
#              --env MYSQL_INIT_SQL="
#                  CREATE SCHEMA \`test1\` DEFAULT CHARACTER SET utf8 ;
#                  CREATE SCHEMA \`test2\` DEFAULT CHARACTER SET utf8 ;
#              " --name test-mysql thinkbase.net/mysql:1.1
# 创建容器, 直接进入终端(常用于排错):
#   docker run -it --rm --name test-mysql thinkbase.net/mysql:1.1 bash
# 以终端方式 Attach 到正在运行的容器:
#   docker exec -it test-mysql bash

FROM thinkbase.net/basic-ubuntu-env:1.0
MAINTAINER thinkbase.net

### 可调整的环境变量 #############################################################
# 参考 00-basic-ubuntu-env
# RT_WORK_COMMAND: 此命令不会被执行到(来自 00-basic-ubuntu-env)
ENV RT_WORK_COMMAND 'echo "Can not reach here !"'
# 默认的 mysql root 密码
ENV MYSQL_ROOT_PWD root
# 初始化数据库时执行的 SQL 语句(默认只是执行 show databases 语句)
ENV MYSQL_INIT_SQL show databases ;
###############################################################################

# 存放 mysql 数据的 Data volume
VOLUME ["/data"]

# mysql 的运行端口 3306
EXPOSE 3306

# 启动脚本 - /docker-init/start.sh - 继承自 00-basic-ubuntu-env

# 必要的配置文件
#ADD resources/ROOT/etc/apt/sources.list /etc/apt/sources.list
ADD resources/ROOT/etc/mysql/my.cnf /opt/etc/mysql/my.cnf

# 安装过程
# Prepare installation
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated cron nano telnet
# change invoke-rc.d to avoid mysql service startup error
RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/invoke-rc.d
RUN export DEBIAN_FRONTEND=noninteractive
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
# Install mysql
RUN apt-get install -y --allow-unauthenticated mysql-server

# 替换 root.sh, 用于启动 MySQL(被 /docker-init/start.sh 调用)
ADD resources/docker-init/etc/root.sh /docker-init/etc/root.sh

