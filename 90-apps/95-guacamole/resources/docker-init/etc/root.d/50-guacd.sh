#! /bin/bash
set -x
set -o nounset
set -o errexit

nohup guacd -f > ${RT_CONSOLE_LOG_PREFIX}guacd.log &
