# thinkbase.net/basic-ubuntu-env: 基本的 Ubuntu 环境
#
# 构造 image:
#   docker build --force-rm -t thinkbase.net/basic-ubuntu-env:20.04.02 .
# 建议用于测试的启动方式:
#   docker run --rm -v /tmp:/test --name test-ubuntu-env thinkbase.net/basic-ubuntu-env:20.04.02
# (或者指定 uid 和 pid)
#   docker run --rm -v /tmp:/test -e RT_WORKER_UID=3000 -e RT_WORKER_GID=3000 --name test-ubuntu-env thinkbase.net/basic-ubuntu-env:20.04.02
# 创建容器, 直接进入终端(常用于排错):
#   docker run -it --rm -v /tmp:/test --name test-ubuntu-env thinkbase.net/basic-ubuntu-env:20.04.02 bash
# 以终端方式 Attach 到正在运行的容器:
#   docker exec -it test-ubuntu-env bash

FROM ubuntu:20.04
MAINTAINER thinkbase.net

### 可调整的环境变量 #############################################################
# RT_WORKER_UID: 用于运行启动脚本的用户 UID
ENV RT_WORKER_UID 1000
# RT_WORKER_GID: 用于运行启动脚本的用户 GID
ENV RT_WORKER_GID 1000
# RT_WORK_COMMAND: 启动后通过 /docker-init/start.sh 执行的命令
ENV RT_WORK_COMMAND "/docker-init/test/test.sh 2017-06-03 '07 24 12'"
###############################################################################

# 更新并安装基本的系统
RUN apt-get update

RUN \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get install -y --allow-unauthenticated apt-utils;
RUN \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get install -y --allow-unauthenticated sudo; \
    apt-get install -y --allow-unauthenticated wget;
RUN \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get install -y --allow-unauthenticated net-tools; \
    apt-get install -y --allow-unauthenticated inetutils-ping;
RUN \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get install -y --allow-unauthenticated telnet; \
    apt-get install -y --allow-unauthenticated nano;
RUN \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get install -y --allow-unauthenticated git;
RUN \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get install -y --allow-unauthenticated curl; \
    apt-get install -y --allow-unauthenticated gnupg2; \
    apt-get install -y --allow-unauthenticated xz-utils;

# 时区设置
RUN \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get install -y --allow-unauthenticated tzdata
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 设置字符集(中文支持)
RUN apt-get install -y locales
RUN locale-gen zh_CN.UTF-8 &&\
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
RUN locale-gen zh_CN.UTF-8  
ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN:zh
ENV LC_ALL zh_CN.UTF-8

# 定制的启动脚本
ADD resources/docker-init /docker-init
CMD ["/docker-init/start.sh"]
