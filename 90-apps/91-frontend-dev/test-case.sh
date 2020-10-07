#!/bin/bash

DEV_HOME=$(pwd)/test-case

mkdir -p ${DEV_HOME}/workspace
mkdir -p ${DEV_HOME}/projects

docker run -it --rm --name frontend-dev-test   \
       -v ${DEV_HOME}/workspace:/work/workspace \
       -v ${DEV_HOME}/projects:/work/projects   \
       -p 58080:58080                          \
       thinkbase.net/frontend-dev:20.04.02 /docker-init/start.sh
