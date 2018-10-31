#!/bin/bash

set -x
set -u

# 启动 nginx
nginx

# 启动时总是处理一次域名申请过程
# (注意! 如果 /etc/letsencrypt 没有使用 VOLUME 放到容器之外的话, 多次创建容器容易打破 Let's Encrypt 的每一 5 次限制！)
certbot --nginx -m "${CERTBOT_EMAIL}" -d "${CERTBOT_DOMAIN}" -n --agree-tos

# 在 nginx 的 配置文件(certbot 会修改它) 中注入关联的附加配置文件( include /sites-enabled/default.d/*.conf )
sed -i '/include\ \/sites-enabled/d' /etc/nginx/nginx.conf
# 在 "ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot" 这句话之后
sed -i 's/^\s*ssl_dhparam\ \/etc\/letsencrypt\/ssl-dhparams.pem\;\ .*managed\ by\ Certbot$/include\ \/sites-enabled\/default.d\/\*\.conf\;/g' /etc/nginx/nginx.conf

# Relood nginx
nginx -s reload

# 最后 tail nginx 日志保证不会退出
tail -f /var/log/nginx/error.log /var/log/nginx/access.log
