---
layout: post
title:  "ThinkPHP + DDEV 本地开发环境搭建"
author: runphp
date:   2025-07-13 20:45:44 +0800
category: php
tags: ddev thinkphp
---

安装DDEV <https://ddev.readthedocs.io/en/stable/users/install/ddev-installation/>

这是我的项目目录结构
```
├── backend
│   ├── app
│   ├── config
│   ├── public
│   ├── runtime
│   ├── ...
│   └── vendor
├── frontend
```

## 配置DDEV

根据自己项目需要配置php版本、数据库版本、上传目录等。

后面再修改也只需要用`ddev config`命令执行修改即可。记得执行`ddev restart`重启服务。
```shell

ddev config --docroot=backend/public --project-type=php --composer-root=backend --php-version=8.2 \
  --xdebug-enabled=true --database=mysql:5.7 --upload-dirs=uploads --web-working-dir=/var/www/html/backend
```

## 添加redis服务
```shell
ddev add-on get ddev/ddev-redis
```

## 启动DDEV
```shell
ddev start
```

## 添加think命令

添加文件`.ddev/commands/web/think`
```shell
#!/usr/bin/env bash

## Description: The ThinkPHP CLI.

./think $@
```
添加后可用`ddev think`命令执行think命令

## 设置ddev环境变量
复制文件`.env`为`.env.ddev`, 并修改为ddev环境默认数据库配置。如下
```ini
# 数据库配置
HOSTNAME = db
HOSTPORT = 3306
USERNAME = db
PASSWORD = db
DATABASE = db
```
修改入口文件`public/index.php`，添加ddev环境变量判断,如下：
```php
$env = getenv('RUNTIME_ENVIRONMENT')?:'';
if (getenv('IS_DDEV_PROJECT') == 'true') {
    $env = 'ddev';
}
$response = $app->setEnvName($env)->http->run();
$response->send();
$app->http->end($response);
```
命令行的`think`命令修改也类似，用`$app->setEnvName($env)`设置环境变量。

## 修改nginx配置

修改nginx配置文件`.ddev/nginx_full/nginx-site.conf`，修改如下
```nginx
location / {
        absolute_redirect off;
        # try_files $uri $uri/ /index.php?$query_string;
        if (!-e $request_filename){
           rewrite  ^(.*)$  /index.php?s=$1  last;   break;
        }
    }
```
记得删除掉`#ddev-generated`注释，不然重启会还原。

## 添加xdebug配置

添加配置文件`.ddev/php/xdebug.ini`，添加如下配置
```ini
[XDEBUG]
xdebug.mode=develop,debug,coverage
xdebug.start_with_request=yes
xdebug.discover_client_host=0
xdebug.client_host=host.docker.internal
xdebug.idekey = vsc
xdebug.client_port="9003"
xdebug.log = "/var/www/html/backend/runtime/xdebug.log"
```

记得debug时idekey使用`xdebug.idekey`配置的值, 我配置的是`vsc`，相同才能在你的IDE中正确识别xdebug。

## 添加php扩展

比如gmp扩展，在 `.ddev/config.yaml` 添加重启即可
```yaml
webimage_extra_packages: ["php${DDEV_PHP_VERSION}-gmp"]
```

## 通过XHGui启用xhprof

先修改配置
`ddev config global --xhprof-mode=xhgui && ddev restart`

开启
`ddev xhgui on`

查看
`ddev xhgui`