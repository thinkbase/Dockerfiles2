export NPM_PREFIX="/work/workspace/nodejs/npm_global"
npm config set prefix "$NPM_PREFIX"
npm config set cache "/work/workspace/nodejs/npm_cache"

export YARN_PREFIX="/work/workspace/yarn/global/node_modules/.bin"
yarn config set prefix "$YARN_PREFIX"
yarn config set global-folder "/work/workspace/yarn/global"
yarn config set cache-folder "/work/workspace/yarn/cache"

# 使用淘宝镜像
npm config set registry https://registry.npm.taobao.org/
yarn config set registry http://registry.npm.taobao.org/

nohup /usr/bin/code-server \
    --auth none \
    --bind-addr 0.0.0.0:58080 \
    --config /work/workspace/code-server/config.yml \
    --user-data-dir /work/workspace/code-server/user-data \
    --extensions-dir /work/workspace/code-server/extensions \
    > /tmp/code-server.log &

export PATH="$PATH:$NPM_PREFIX/bin:$YARN_PREFIX/bin:"

export PS1_GREEN="\[$(tput bold)$(tput setaf 2)\]"
export PS1_RESET="\[$(tput sgr0)\]"
export PROMPT_COMMAND='PS1="${PS1_GREEN}[${RT_PROMPT}] ${PS1_RESET}\W${PS1_GREEN} > ${PS1_RESET}"'
