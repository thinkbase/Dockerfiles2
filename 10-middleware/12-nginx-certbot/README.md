## 构造 image

   `docker build --force-rm -t thinkbase.net/nginx-certbot:1.0 .`

- 可以使用代理服务器, 比如:

  ```shell
  docker build --force-rm -t thinkbase.net/nginx-certbot:1.0 . \
         --build-arg http_proxy="http://172.17.0.1:8123" \
         --build-arg https_proxy="http://172.17.0.1:8123"
  ```



## 运行(测试)

- 用于测试的启动方式(*注意 host 机器上 80/443 端口需要开放*):

  ```shell
  docker run --rm --name test-nginx-certbot thinkbase.net/nginx-certbot:1.0 \
         -v $(pwd)/test/sites-enabled/default.d:/sites-enabled/default.d \
         -v $(pwd)/test/letsencrypt:/etc/letsencrypt \
         -p 80:80 -p 443:443
  ```

- 创建容器, 直接进入终端(常用于排错, *注意 host 机器上 80/443 端口需要开放*):

  ```shell
  docker run -it --rm --name test-nginx-certbot thinkbase.net/nginx-certbot:1.0 \
         -v $(pwd)/test/sites-enabled/default.d:/sites-enabled/default.d \
         -v $(pwd)/test/letsencrypt:/etc/letsencrypt \
         -p 80:80 -p 443:443 bash
  ```

- 以终端方式 Attach 到正在运行的容器:

  ```shell
  docker exec -it test-nginx-certbot bash
  ```


## END