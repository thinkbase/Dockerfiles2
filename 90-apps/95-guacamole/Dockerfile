# thinkbase.net/guacamole: 在 Ubuntu 的基础上安装 guacamole 服务器
#  - 9.0-01 - 初始版本, 基于自带的 guacamole 1.3.0
#
# 构造 image:
#   docker build --force-rm -t thinkbase.net/guacamole:1.3-01 .
# 正常运行/启动(注意合理的参数: -p、-v、--env、--name):
#   docker run --rm -p 8080:8080 -v $(pwd)/test/guacamole-config:/guacamole-config --name test-guacamole thinkbase.net/guacamole:1.3-01
# 创建临时容器, 直接进入终端(常用于排错):
#   docker run --rm -p 8080:8080 -v $(pwd)/test/guacamole-config:/guacamole-config -it --rm thinkbase.net/guacamole:1.3-01 bash
# 以终端方式 Attach 到正在运行的容器:
#   docker exec -it test-guacamole bash

FROM thinkbase.net/tomcat:9.0-01
MAINTAINER thinkbase.net

ENV GUAC_VER=1.3.0

# 自定义的 guacamole 的 config 目录位置
VOLUME ["/guacamole-config"]

# guacamole 的运行端口
EXPOSE 8080
#==============================================================================

# 安装必要的文件
RUN apt-get update
RUN apt-get install -y build-essential \
    libcairo2-dev libjpeg-turbo8-dev libpng-dev \
    libossp-uuid-dev libavcodec-dev libavutil-dev \
    libswscale-dev freerdp2-dev libfreerdp-client2-2 libpango1.0-dev \
    libssh2-1-dev libtelnet-dev libvncserver-dev \
    libpulse-dev libssl-dev libvorbis-dev libwebp-dev libwebsockets-dev \
    ghostscript

# Install guacamole-server
RUN curl -SLO "http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/${GUAC_VER}/source/guacamole-server-${GUAC_VER}.tar.gz" \
  && tar -xzf guacamole-server-${GUAC_VER}.tar.gz \
  && cd guacamole-server-${GUAC_VER} \
  && ./configure --enable-allow-freerdp-snapshots \
  && make -j$(getconf _NPROCESSORS_ONLN) \
  && make install \
  && cd .. \
  && rm -rf guacamole-server-${GUAC_VER}.tar.gz guacamole-server-${GUAC_VER} \
  && ldconfig

# Install guacamole-client and postgres auth adapter
RUN set -x \
  && rm -rf ${CATALINA_WEBAPPS}/ROOT \
  && curl -SLo ${CATALINA_WEBAPPS}/ROOT.war "http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/${GUAC_VER}/binary/guacamole-${GUAC_VER}.war"

ENV GUACAMOLE_HOME=/guacamole-config
ADD resources/docker-init/etc/root.d/50-guacd.sh /docker-init/etc/root.d/50-guacd.sh

