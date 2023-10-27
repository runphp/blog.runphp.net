---
layout: post
title:  "Alibaba Cloud Linux安装docker"
date:   2023-10-26 17:22:32 +0800
category: linux
tags: docker
---

安装了Alibaba Cloud Linux  3.2104 LTS 64位的系统，需要部署一下docker，系统默认是`podman-docker`

步骤如下

1. 运行以下命令，添加docker-ce的dnf源。

   ```shell
   sudo dnf config-manager --add-repo=https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
   ```

2. 运行以下命令，安装Alibaba Cloud Linux 3专用的dnf源兼容插件。

   ```shell
   sudo dnf -y install dnf-plugin-releasever-adapter --repo alinux3-plus
   ```

3. 运行以下命令，安装Docker。

   ```shell
   sudo dnf -y install docker-ce --nobest
   ```



执行以下命令，检查Docker是否安装成功。

```shell
sudo docker -v
```

执行以下命令，启动Docker服务，并设置开机自启动。

```shell
sudo systemctl start docker
sudo systemctl enable docker
```

执行以下命令，查看Docker是否启动。

```shell
sudo systemctl status docker
```