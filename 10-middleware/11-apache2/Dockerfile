# thinkbase.net/apache2: 在 Ubuntu 的基础上安装 apache2 服务器
#  - 1.0 - 初始版本
#  - 1.1 - 优化，主要是原来 volume /www 改为 /sites-enabled 以支持多个 apache 配置文件, 同时增加了 mod_headers 模块
#  - 2.0 - 修改为基于 basic-ubuntu-env 启动, 这样可以统一解决时区等问题
#
# 构造 image:
#   docker build --force-rm -t thinkbase.net/apache2:2.0 .
#   (可以使用代理服务器, 比如
#      docker build --force-rm -t thinkbase.net/apache2:2.0 . --build-arg http_proxy="http://172.17.0.1:8123" --build-arg https_proxy="http://172.17.0.1:8123"
#   )
# 正常运行/启动(注意合理的参数: -p、-v、--env、--name):
#   docker run --rm -p 8080:8080 -v $(pwd)/test/sites-enabled:/sites-enabled --name test-apache2 thinkbase.net/apache2:2.0
# 创建临时容器, 直接进入终端(常用于排错):
#   docker run --rm -p 8080:8080 -v $(pwd)/test/sites-enabled:/sites-enabled -it --rm thinkbase.net/apache2:2.0 bash
# 以终端方式 Attach 到正在运行的容器:
#   docker exec -it test-apache2 bash

FROM thinkbase.net/basic-ubuntu-env:1.0
MAINTAINER thinkbase.net

### 可调整的环境变量 #############################################################
# 参考 00-basic-ubuntu-env
# RT_WORK_COMMAND: 此命令不会被执行到(来自 00-basic-ubuntu-env)
ENV RT_WORK_COMMAND 'echo "Can not reach here !"'
###############################################################################

# 自定义的 Apache 的 sites-enabled 目录位置(如果存在 Web 资源、配置文件等 volume 需求，可以在运行是自行定义其他 volume)
VOLUME ["/sites-enabled"]

# Apache2 的运行端口
EXPOSE 8080
#==============================================================================

# 安装必要的文件
RUN apt-get update
RUN apt-get install -y apache2

RUN a2enmod xml2enc authnz_ldap ldap proxy proxy_http proxy_html rewrite headers
RUN mkdir -p /var/lock/apache2

# Deploy default apache conf
RUN rm -Rfv /etc/apache2/sites-enabled
RUN ln -sv /sites-enabled /etc/apache2/sites-enabled

# 替换 root.sh (被 /docker-init/start.sh 调用)
ADD resources/docker-init/etc/root.sh /docker-init/etc/root.sh
