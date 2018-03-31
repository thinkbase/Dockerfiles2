#!/bin/bash

# 输出时间
date

# 显示用户信息
id

# 输出数据到 /test
echo "Hello, World!" > /test/${USER}
echo "----" >> /test/${USER}
echo "$*"   >> /test/${USER}
echo "----" >> /test/${USER}
env         >> /test/${USER}

echo ">>> /test/${USER} created. Now waiting 120 seconds ..."
sleep 120
echo ">>> Bye!" 
