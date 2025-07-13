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

后面在修改也只需要用`ddev config`命令执行修改即可。记得执行`ddev restart`重启服务。
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