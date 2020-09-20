#!/bin/bash

source /etc/profile

export NPM_PREFIX="/frontend/workspace/nodejs/npm_global"
npm config set prefix "$NPM_PREFIX"
npm config set cache "/frontend/workspace/nodejs/npm_cache"

export YARN_PREFIX="/frontend/workspace/yarn/global/node_modules/.bin"
yarn config set prefix "$YARN_PREFIX"
yarn config set global-folder "/frontend/workspace/yarn/global"
yarn config set cache-folder "/frontend/workspace/yarn/cache"

# 使用淘宝镜像
npm config set registry https://registry.npm.taobao.org/
yarn config set registry http://registry.npm.taobao.org/

nohup /usr/bin/code-server \
    --auth none \
    --bind-addr 0.0.0.0:58080 \
    --config /frontend/workspace/code-server/config.yml \
    --user-data-dir /frontend/workspace/code-server/user-data \
    --extensions-dir /frontend/workspace/code-server/extensions \
    > /tmp/code-server.log &

export PATH="$PATH:$NPM_PREFIX/bin:$YARN_PREFIX/bin:"

export PS1_GREEN="\[$(tput bold)$(tput setaf 2)\]"
export PS1_RESET="\[$(tput sgr0)\]"
export PROMPT_COMMAND='PS1="${PS1_GREEN}[FRONTEND-DEV] ${PS1_RESET}\W${PS1_GREEN} > ${PS1_RESET}"'

cd /frontend/projects
bash
