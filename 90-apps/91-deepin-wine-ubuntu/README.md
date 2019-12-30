## 构造 image

   

```shell
docker build --force-rm -t thinkbase.net/deepin-wine-ubuntu:1.0 .
```

- 可以使用代理服务器, 比如:

  ```shell
  docker build --force-rm -t thinkbase.net/deepin-wine-ubuntu:1.0 . \
         --build-arg http_proxy="http://172.17.0.1:8123" \
         --build-arg https_proxy="http://172.17.0.1:8123"
  ```



## 运行(测试)

- 正常运行/启动 ( **在当前目录下执行**， 注意合理的参数: `-v`、`--env`、`--name `)：

  ```shell
  docker run --rm -v $(pwd)/test:/root/install \
             -v /tmp/.X11-unix:/tmp/.X11-unix \
             -e DISPLAY=unix$DISPLAY -e GDK_SCALE -e GDK_DPI_SCALE \
             --name test-deepin-wine-ubuntu thinkbase.net/deepin-wine-ubuntu:1.0
  ```
  
- 创建容器, 直接进入终端 ( **在当前目录下执行** )：

  ```shell
  docker run --rm -v $(pwd)/test:/root/install \
             -v /tmp/.X11-unix:/tmp/.X11-unix \
             -e DISPLAY=unix$DISPLAY -e GDK_SCALE -e GDK_DPI_SCALE \
             -it --rm thinkbase.net/deepin-wine-ubuntu:1.0 bash
  ```
  
- 以终端方式 Attach 到正在运行的容器：

  ```shell
  docker exec -it test-deepin-wine-ubuntu bash
  ```



### 启动测试应用(7zip)

在按照上述“正常运行/启动”启动 `test-deepin-wine-ubuntu` 容器后，在 host 机器中执行：

```shell
docker exec -it test-deepin-wine-ubuntu bash 7zip.sh
```



### 安装其他应用(测试)

注意 `/root/install` 不是必须的，是为了安装测试方便映射的：

- 到 [阿里云镜像](http://mirrors.aliyun.com/deepin/pool/non-free/d/) 下载相应应用的 deb 文件到当前目录;

- 进入容器后，在 `/root/install` 目录执行安装：

  ```bash
  dpkg -i *.deb
  apt install -f
  ```

- 然后进入 `/opt/deepinwine/apps` 下具体应用的子目录，执行 `./run.sh` 。



### 执行 windows 命令

- 进入容器：

  ```shell
  docker exec -it test-deepin-wine-ubuntu bash
  ```

- su 为 u01 用户：

  ```shell
  su - u01
  ```

- 然后使用 `deepin-wine XXX` 方式执行：

  ```shell
  deepin-wine regedit
  deepin-wine cmd
  ```

  

## END