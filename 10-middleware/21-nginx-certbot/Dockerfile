# thinkbase.net/nginx-certbot: 在 Ubuntu 的基础上安装 certbot 服务, 在 nginx 的基础上提供 HTTPS 接入服务
#
# 构造 image:
#   docker build --force-rm -t thinkbase.net/nginx-certbot:1.0 .
#   (可以使用代理服务器, 比如
#      docker build --force-rm -t thinkbase.net/nginx-certbot:1.0 . --build-arg http_proxy="http://172.17.0.1:8123" --build-arg https_proxy="http://172.17.0.1:8123"
#   )

# 创建容器, 直接进入终端(常用于排错):
#   docker run -it --rm -v /tmp:/test -p 80:80 -p 443:443 --name test-nginx-certbot thinkbase.net/nginx-certbot:1.0 bash


# 建议用于测试的启动方式:
#   docker run --rm -v /tmp:/test --name test-nginx-certbot thinkbase.net/nginx-certbot:1.0
# (或者指定 uid 和 pid)
#   docker run --rm -v /tmp:/test -e RT_WORKER_UID=3000 -e RT_WORKER_GID=3000 --name test-nginx-certbot thinkbase.net/nginx-certbot:1.0
# 创建容器, 直接进入终端(常用于排错):
#   docker run -it --rm -v /tmp:/test -p 80:80 -p 443:443 --name test-nginx-certbot thinkbase.net/nginx-certbot:1.0 bash
# 以终端方式 Attach 到正在运行的容器:
#   docker exec -it test-nginx-certbot bash

FROM thinkbase.net/basic-ubuntu-env:1.0
MAINTAINER thinkbase.net

### 可调整的环境变量 #############################################################
# 参考 00-basic-ubuntu-env
# RT_WORK_COMMAND: 此命令不会被执行到(来自 00-basic-ubuntu-env)
ENV RT_WORK_COMMAND 'echo "Can not reach here !"'
###############################################################################

#==============================================================================

# 安装必要的文件
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated software-properties-common
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:certbot/certbot
RUN apt-get update
apt-get install -y --allow-unauthenticated python-certbot-nginx
