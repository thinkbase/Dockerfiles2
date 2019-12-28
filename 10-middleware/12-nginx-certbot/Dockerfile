# thinkbase.net/nginx-certbot: 在 Ubuntu 的基础上安装 certbot 服务, 在 nginx 的基础上提供 HTTPS 接入服务

FROM thinkbase.net/basic-ubuntu-env:1.0
MAINTAINER thinkbase.net

### 可调整的环境变量 #############################################################
# 参考 00-basic-ubuntu-env
# RT_WORK_COMMAND: 此命令不会被执行到(来自 00-basic-ubuntu-env)
ENV RT_WORK_COMMAND 'echo "Can not reach here !"'
###############################################################################

# 证书申请的环境(email 和 域名, 多个域名可以使用逗号分隔输入)
ENV CERTBOT_EMAIL "thinkbase.net@gmail.com"
ENV CERTBOT_DOMAIN "thinkbase.tech,www.thinkbase.tech"

# 定义的 nginx "default" site 的附加配置的目录位置(如果存在 Web 资源、配置文件等 volume 需求，可以在运行时自行定义其他 volume)
# 注意: 附加配置并不是 nginx 安装版本自带的 "/etc/nginx/conf.d", 而是在 server {...} 内层的配置, 直接影响 default site
VOLUME /sites-enabled/default.d

# Let's Encrypt 证书存储
# (注意! 如果 /etc/letsencrypt 没有使用 VOLUME 放到容器之外的话, 多次创建容器容易打破 Let's Encrypt 的每月 5 次限制！)
VOLUME /etc/letsencrypt

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
