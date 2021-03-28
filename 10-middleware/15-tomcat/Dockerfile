# thinkbase.net/tomcat: 在 Ubuntu 的基础上安装 tomcat 服务器
#  - 9.0-01 - 初始版本, 基于自带的 tomcat9
#
# 构造 image:
#   docker build --force-rm -t thinkbase.net/tomcat:9.0-01 .
# 正常运行/启动(注意合理的参数: -p、-v、--env、--name):
#   docker run --rm -p 8080:8080 -v $(pwd)/test/webapps:/webapps --name test-tomcat thinkbase.net/tomcat:9.0-01
# 创建临时容器, 直接进入终端(常用于排错):
#   docker run --rm -p 8080:8080 -v $(pwd)/test/webapps:/webapps -it --rm thinkbase.net/tomcat:9.0-01 bash
# 以终端方式 Attach 到正在运行的容器:
#   docker exec -it test-tomcat bash

FROM thinkbase.net/basic-ubuntu-env:20.04-03
MAINTAINER thinkbase.net

### 可调整的环境变量 #############################################################
# 参考 00-basic-ubuntu-env
# RT_WORK_COMMAND: 此命令不会被执行到(来自 00-basic-ubuntu-env)
ENV RT_WORK_COMMAND 'echo "Can not reach here !"'
###############################################################################

# 自定义的 Tomcat 的 webapps 目录位置
VOLUME ["/webapps"]

# tomcat 的运行端口
EXPOSE 8080
#==============================================================================

# 安装必要的文件
RUN apt-get update
RUN apt-get install -y tomcat9

# Deploy default apache conf
RUN rm -Rfv /var/lib/tomcat9/webapps
RUN ln -sv /webapps /var/lib/tomcat9/webapps

# 替换 root.sh (被 /docker-init/start.sh 调用)
ADD resources/docker-init/etc/root.sh /docker-init/etc/root.sh