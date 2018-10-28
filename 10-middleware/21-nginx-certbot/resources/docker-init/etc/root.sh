#!/bin/bash

# 启动 nginx
nginx

# 启动时总是处理一次域名申请过程
certbot --nginx -m "${CERTBOT_EMAIL}" -d "${CERTBOT_DOMAIN}" -n --agree-tos

# 最后 tail nginx 日志保证不会退出
tail -f /var/log/nginx/error.log /var/log/nginx/access.log