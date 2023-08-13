---
layout: post
title:  "podman 出现listen tcp4 0.0.0.0:80: bind: permission denied"
author: runphp
date:   2023-08-12 18:03:04 +0800
category: other
tags: podman
---

podman在绑定低于1024的端口时出现以下错误

```
podman start wordpress_nginx_1
Error: unable to start container "50f39c79e0458886cdb54d98cfc8d415fdc3ccc822ef7c4701dabcbaf7b8aebb": rootlessport cannot expose privileged port 80, you can add 'net.ipv4.ip_unprivileged_port_start=80' to /etc/sysctl.conf (currently
1024), or choose a larger port number (>= 1024): listen tcp4 0.0.0.0:80: bind: permission denied
exit code: 125
```


如果有印象的话其实在运行`podman machine start`到时候就已经有提示了

```
PS D:\wordpress> podman machine start
Starting machine "podman-machine-default"

This machine is currently configured in rootless mode. If your containers
require root permissions (e.g. ports < 1024), or if you run into compatibility
issues with non-podman clients, you can switch using the following command:

        podman machine set --rootful

API forwarding listening on: npipe:////./pipe/docker_engine

Docker API clients default to this address. You do not need to set DOCKER_HOST.
Machine "podman-machine-default" started successfully
```


所以只需要运行`podman machine set --rootful`即可解决这个问题