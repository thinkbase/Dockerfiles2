# thinkbase.net/deepin-wine-ubuntu: 在 Ubuntu 的基础上安装 deepin-wine-ubuntu 环境

FROM thinkbase.net/basic-ubuntu-env:18.04
MAINTAINER thinkbase.net

### 可调整的环境变量 #############################################################
# 参考 00-basic-ubuntu-env
# RT_WORK_COMMAND: 此命令不会被执行到(来自 00-basic-ubuntu-env)
ENV RT_WORK_COMMAND 'echo "Can not reach here !"'
###############################################################################

# 安装必要的文件
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get install ttf-wqy-zenhei -y
RUN apt-get clean && apt-get autoclean
ENV LC_CTYPE=zh_CN.UTF-8 \
    XMODIFIERS="@im=fcitx"

RUN \
  locale-gen en_US.UTF-8 zh_CN.UTF-8 \
  zh_CN.GBK && \
  update-locale LANG=zh_CN.UTF-8
  
# 安装 deepin-wine-ubuntu
RUN mkdir -p /root
RUN git clone https://github.com/wszqkzqk/deepin-wine-ubuntu.git /root/deepin-wine-ubuntu
RUN yes|bash /root/deepin-wine-ubuntu/install.sh
RUN rm -rf /root/deepin-wine-ubuntu
WORKDIR /root

# 安装基本应用
ADD resources/deb /root/deb
RUN dpkg -i /root/deb/*.deb
RUN apt-get install -f -y

# 可以直接执行的 wine 程序脚本
ADD resources/7zip.sh /usr/local/bin/

# 替换 root.sh (被 /docker-init/start.sh 调用)
ADD resources/docker-init/etc/root.sh /docker-init/etc/root.sh
