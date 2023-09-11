---
title: Jekyll github metadata 使用说明
category: ruby
date: '2023-09-08 19:23:45'
tags: github-metadata jekyll
---

### 安装
执行以下命令添加插件
`bundle add jekyll-github-metadata`

在`_config.yml`添加仓库名repository

例如：

{% highlight yml mark_lines="3" %}
baseurl: ""
url: "https://blog.runphp.net"
repository: runphp/blog.runphp.net
author: runphp
{% endhighlight %}

###  使用示例

#### Using site.github

获取所有开源项目的信息
```html
{% raw %}
<div class="list-group">
{% for repository in site.github.public_repositories %}
  <a href="{{ repository.html_url }}" class="list-group-item list-group-item-action" aria-current="true">
    <div class="d-flex w-100 justify-content-between">
      <h5 class="mb-1 no_toc">{{ repository.name }}</h5>
      <small>pushed at {{repository.pushed_at | date:"%Y-%m-%d %H:%M:%S"}}</small>
    </div>
    <p class="mb-1">{{ repository.description }}</p>
    <small>language {{repository.language}}</small>
  </a>
{% endfor %}
</div>
{% endraw %}
```

#### Edit on GitHub link

提供github文件链接


```html
{% raw %}{% github_edit_link "编辑此文件" %}{% endraw %}
```

效果如下

```html
{% github_edit_link "编辑此文件" %}
```


### 运行时github token 的传递

linux

```sh
JEKYLL_GITHUB_TOKEN=123abc [bundle exec] jekyll s --verbose --trace
```

windows 

```powershell
$env:JEKYLL_GITHUB_TOKEN='github_pat_1XXXXXXXXXXXXXXXXX';  bundle exec jekyll s --verbose --trace
```

在github actions 通过 secrets变量传递

```yml
{% raw %}
 run: JEKYLL_GITHUB_TOKEN=${{ secrets.JEKYLL_GITHUB_TOKEN }} && bundle exec jekyll build --verbose --trace
{% endraw %}
```