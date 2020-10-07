# thinkbase.net/frontend-dev: 前端开发环境
#
# 构造 image:
#   docker build --force-rm -t thinkbase.net/frontend-dev:20.04.02 .
# 创建容器, 直接进入终端(用于开发):
#   见 ./test-case.sh
# (或者指定 uid 和 pid: -e RT_WORKER_UID=3000 -e RT_WORKER_GID=3000)

FROM thinkbase.net/basic-ubuntu-env:20.04.02
MAINTAINER thinkbase.net

### 可调整的环境变量 #############################################################
# RT_WORKER_UID: 用于运行启动脚本的用户 UID
#ENV RT_WORKER_UID 1000
# RT_WORKER_GID: 用于运行启动脚本的用户 GID
#ENV RT_WORKER_GID 1000
# RT_WORK_COMMAND: 启动后通过 /docker-init/start.sh 执行的命令
ENV RT_WORK_COMMAND "cd /work/projects ; bash"
###############################################################################

### 命令行提示
ENV RT_PROMPT "FRONTEND-DEV"

### 安装软件的版本号
ENV NODE_VER 12.19.0
ENV CODE_SERVER_VER 3.5.0

# code-server 的运行端口
EXPOSE 58080
# code-server 工作空间目录 和 项目目录
VOLUME ["/work/workspace", "/work/projects"]

# 安装 nodejs
RUN wget -O "/tmp/node-v${NODE_VER}-linux-x64.tar.xz" https://nodejs.org/dist/v${NODE_VER}/node-v${NODE_VER}-linux-x64.tar.xz
RUN tar xvJf "/tmp/node-v${NODE_VER}-linux-x64.tar.xz" -C /opt
RUN echo "" >> /etc/profile
RUN echo "#Install nodejs v${NODE_VER}" >> /etc/profile
RUN echo "export PATH=/opt/node-v${NODE_VER}-linux-x64/bin:\$PATH" >> /etc/profile
RUN rm -rf "/tmp/node-v${NODE_VER}-linux-x64.tar.xz"

# 安装 yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install -y --no-install-recommends yarn

# 安装 code-server
ADD resources/tmp /tmp
RUN if test -f /tmp/code-server_${CODE_SERVER_VER}_amd64.deb ; then \
	  echo "/tmp/code-server_${CODE_SERVER_VER}_amd64.deb found ."; \
	else \
	  wget -O "/tmp/code-server_${CODE_SERVER_VER}_amd64.deb" \
	       https://github.com/cdr/code-server/releases/download/v${CODE_SERVER_VER}/code-server_${CODE_SERVER_VER}_amd64.deb ; \
	fi
RUN dpkg -i "/tmp/code-server_${CODE_SERVER_VER}_amd64.deb"
RUN rm -f "/tmp/code-server_${CODE_SERVER_VER}_amd64.deb"

# 启动脚本
ADD resources/docker-init /docker-init
CMD ["/docker-init/start.sh"]
