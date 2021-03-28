# thinkbase.net/tomcat: 在 Ubuntu 的基础上安装 tomcat 服务器
#  - 9.0-01 - 初始版本, 基于自带的 tomcat9
#
# 构造 image:
#   docker build --force-rm -t thinkbase.net/tomcat:9.0-01 .
# 正常运行/启动(注意合理的参数: -p、-v、--env、--name):
#   docker run --rm -p 8080:8080 -v $(pwd)/test/webapps:/var/lib/tomcat9/webapps --name test-tomcat thinkbase.net/tomcat:9.0-01
# 创建临时容器, 直接进入终端(常用于排错):
#   docker run --rm -p 8080:8080 -v $(pwd)/test/webapps:/var/lib/tomcat9/webapps -it --rm thinkbase.net/tomcat:9.0-01 bash
# 以终端方式 Attach 到正在运行的容器:
#   docker exec -it test-tomcat bash

FROM thinkbase.net/basic-ubuntu-env:20.04-03
MAINTAINER thinkbase.net

# Tomcat 的 webapps 目录
ENV CATALINA_WEBAPPS=/var/lib/tomcat9/webapps

# 应用日志目录前缀(在可能存在多个应用的情况下, 采用 tail 符合前缀的所有日志的方式来实现容器终端输出)
ENV RT_CONSOLE_LOG_PREFIX=/tmp/tomcat-container-

# 参考 00-basic-ubuntu-env , 使用此命令执行最后的 tail
ENV RT_WORK_COMMAND 'tail -f ${RT_CONSOLE_LOG_PREFIX}*.log'

# tomcat 的运行端口
EXPOSE 8080
#==============================================================================

# 安装必要的文件
RUN apt-get update
RUN apt-get install -y tomcat9

# 启动需要的脚本 (被 /docker-init/start.sh 调用)
ADD resources/docker-init/etc/root.d/50-tomcat-prepare.sh /docker-init/etc/root.d/50-tomcat-prepare.sh
ADD resources/docker-init/etc/u01.d/50-tomcat-start.sh    /docker-init/etc/u01.d/50-tomcat-start.sh

# 设定命令行启动必须的环境变量 (ref: /lib/systemd/system/tomcat9.service)
ENV CATALINA_HOME=/usr/share/tomcat9
ENV CATALINA_BASE=/var/lib/tomcat9
ENV CATALINA_TMPDIR=/tmp
ENV JAVA_OPTS=-Djava.awt.headless=true
