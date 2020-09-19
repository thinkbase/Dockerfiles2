# thinkbase.net/frontend-dev: 前端开发环境
#
# 构造 image:
#   docker build --force-rm -t thinkbase.net/frontend-dev:20.04.01 .
# 创建容器, 直接进入终端(用于开发):
#   docker run -it --rm -v $(pwd):/work --name test-frontend-dev thinkbase.net/frontend-dev:20.04.01 /docker-init/start.sh
# (或者指定 uid 和 pid)
#   docker run -it --rm -v $(pwd):/work -e RT_WORKER_UID=3000 -e RT_WORKER_GID=3000 --name test-frontend-dev thinkbase.net/frontend-dev:20.04.01 /docker-init/start.sh

FROM thinkbase.net/basic-ubuntu-env:20.04
MAINTAINER thinkbase.net

### 可调整的环境变量 #############################################################
# RT_WORKER_UID: 用于运行启动脚本的用户 UID
#ENV RT_WORKER_UID 1000
# RT_WORKER_GID: 用于运行启动脚本的用户 GID
#ENV RT_WORKER_GID 1000
# RT_WORK_COMMAND: 启动后通过 /docker-init/start.sh 执行的命令
ENV RT_WORK_COMMAND "echo '系统退出 ...'"
###############################################################################

ENV NODE_VER 12.18.4

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

# 启动脚本
ADD resources/docker-init /docker-init
CMD ["/docker-init/start.sh"]
