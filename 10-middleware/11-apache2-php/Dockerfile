# thinkbase.net/apache2-php: 在 thinkbase.net/apache2 的基础上安装 php, 包括 mysql 支持
#  - 2.0 - 初始版本
#
# 构造 image:
#   docker build --force-rm -t thinkbase.net/apache2-php:2.0 .
#   (可以使用代理服务器, 比如
#      docker build --force-rm -t thinkbase.net/apache2-php:2.0 . --build-arg http_proxy="http://172.17.0.1:8123" --build-arg https_proxy="http://172.17.0.1:8123"
#   )
# 正常运行/启动(注意合理的参数: -p、-v、--env、--name):
#   docker run --rm -p 8080:8080 \
#          -v $(pwd)/test/sites-enabled:/sites-enabled -v $(pwd)/test/www:/var/www/html \
#          --env LATEST_PHP_INI="/sites-enabled/php/patch.ini" \
#          --name test-php thinkbase.net/apache2-php:2.0
# 创建临时容器, 直接进入终端(常用于排错):
#   docker run --rm -p 8080:8080 \
#          -v $(pwd)/test/sites-enabled:/sites-enabled -v $(pwd)/test/www:/var/www/html \
#          --env LATEST_PHP_INI="/sites-enabled/php/patch.ini" \
#          -it --rm thinkbase.net/apache2-php:2.0 bash
# 以终端方式 Attach 到正在运行的容器:
#   docker exec -it test-php bash

FROM thinkbase.net/apache2:2.0
MAINTAINER thinkbase.net

### 可调整的环境变量 #############################################################
# 参考 00-basic-ubuntu-env
# RT_WORK_COMMAND: 此命令不会被执行到(来自 00-basic-ubuntu-env)
ENV RT_WORK_COMMAND 'echo "Can not reach here !"'

# LATEST_PHP_INI: 定义附加到 php.ini 上的附加配置;
# 该变量指向的文件(如果存在的话)将被链接到 /etc/php/7.0/apache2/conf.d/99-latest-php.ini
ENV LATEST_PHP_INI "/not-exist.ini"
###############################################################################

# 自定义的 Apache 的 sites-enabled 目录位置(如果存在 Web 资源、配置文件等 volume 需求，可以在运行是自行定义其他 volume)
VOLUME ["/sites-enabled"]

# Apache2 的运行端口
EXPOSE 8080
#==============================================================================

# 安装必要的文件
RUN apt-get update
RUN apt-get install -y php libapache2-mod-php php-mysql php-gd

# 替换 root.sh (被 /docker-init/start.sh 调用)
ADD resources/docker-init/etc/root.sh /docker-init/etc/root.sh
