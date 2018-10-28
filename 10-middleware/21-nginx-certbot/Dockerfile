# thinkbase.net/nginx-certbot: 在 Ubuntu 的基础上安装 certbot 服务, 在 nginx 的基础上提供 HTTPS 接入服务
#
# 构造 image:
#   docker build --force-rm -t thinkbase.net/nginx-certbot:1.0 .
#   (可以使用代理服务器, 比如
#      docker build --force-rm -t thinkbase.net/nginx-certbot:1.0 . --build-arg http_proxy="http://172.17.0.1:8123" --build-arg https_proxy="http://172.17.0.1:8123"
#   )
# 建议用于测试的启动方式(意 host 机器上 80/443 端口需要开放):
#   docker run --rm -v /tmp/test-nginx-certbot:/etc/nginx/conf.d -p 80:80 -p 443:443 --name test-nginx-certbot thinkbase.net/nginx-certbot:1.0
# 创建容器, 直接进入终端(常用于排错, 注意 host 机器上 80/443 端口需要开放):
#   docker run -it --rm -v /tmp/test-nginx-certbot:/etc/nginx/conf.d -p 80:80 -p 443:443 --name test-nginx-certbot thinkbase.net/nginx-certbot:1.0 bash
# 以终端方式 Attach 到正在运行的容器:
#   docker exec -it test-nginx-certbot bash

FROM thinkbase.net/basic-ubuntu-env:1.0
MAINTAINER thinkbase.net

### 可调整的环境变量 #############################################################
# 参考 00-basic-ubuntu-env
# RT_WORK_COMMAND: 此命令不会被执行到(来自 00-basic-ubuntu-env)
ENV RT_WORK_COMMAND 'echo "Can not reach here !"'
###############################################################################

# 证书申请的环境(email 和 域名, 多个域名可以使用逗号分隔输入)
ENV CERTBOT_EMAIL "thinkbase.net@gmail.com"
ENV CERTBOT_DOMAIN "thinkbase.net,www.thinkbase.net"

# 自定义的 nginx 的 conf.d 目录位置(如果存在 Web 资源、配置文件等 volume 需求，可以在运行时自行定义其他 volume)
VOLUME ["/etc/nginx/conf.d"]

# nginx 的运行端口 - certbot 执行过程中总是通过域名访问服务器的 80 端口
EXPOSE 80
#==============================================================================

# 安装必要的文件
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated software-properties-common
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:certbot/certbot
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated python-certbot-nginx

# 替换 root.sh (被 /docker-init/start.sh 调用)
ADD resources/docker-init/etc/root.sh /docker-init/etc/root.sh
