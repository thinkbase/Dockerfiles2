# thinkbase.net/fullstack-dev: 前后端全栈开发环境
#
# 构造 image:
#   docker build --force-rm -t thinkbase.net/fullstack-dev:20.04.02 .
# 创建容器, 直接进入终端(用于开发):
#   见 ./test-case.sh
# (或者指定 uid 和 pid: -e RT_WORKER_UID=3000 -e RT_WORKER_GID=3000)

FROM thinkbase.net/frontend-dev:20.04.02
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
ENV RT_PROMPT "FULLSTACK-DEV"

# OpenJDK 11
RUN wget -O "/tmp/jdk-11.0.8+10.tar.gz" \
    https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.8%2B10/OpenJDK11U-jdk_x64_linux_hotspot_11.0.8_10.tar.gz
RUN tar xzvf /tmp/jdk-11.0.8+10.tar.gz -C /opt
RUN echo "#Install OpenJDK 11" >> /etc/profile
RUN echo "export JAVA_HOME=/opt/jdk-11.0.8+10" >> /etc/profile
RUN echo "export PATH=/opt/jdk-11.0.8+10/bin:\$PATH" >> /etc/profile
RUN rm -fv /tmp/jdk-11.0.8+10.tar.gz

# Maven 3.6
RUN wget -O "/tmp/apache-maven-3.6.3-bin.tar.gz" \
    https://mirror.bit.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
RUN tar xzvf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt
RUN echo "#Install Maven 3.6" >> /etc/profile
RUN echo "export M2_HOME=/opt/apache-maven-3.6.3" >> /etc/profile
RUN echo "export PATH=/opt/apache-maven-3.6.3/bin:\$PATH" >> /etc/profile
RUN rm -fv /tmp/apache-maven-3.6.3-bin.tar.gz

# 启动脚本
ADD resources/docker-init /docker-init
CMD ["/docker-init/start.sh"]
