---
layout: post
title:  "Jekyll如何添加上一页下一页链接"
author: runphp
date:   2023-08-16 17:36:07 +0800
category: ruby
tags: jekyll
---

如果你需要给Jekyll博文页添加上一页/下一页, 那么只需要编辑`_layouts/post.html`, 在适合的位置加上你的html代码，用到的模板变量为`page.previous`
和`page.next`,是不是很简单。

示例代码如下
{% highlight html linenos%}
{% raw %}
<div class="row">
    {% if page.previous.url %}
    <span class="col-lg-6 col-sm-12">
        <i class="bi bi-arrow-left mx-1" aria-hidden="true"></i>
        <a class="link-underline-secondary" href="{{page.previous.url}}">{{page.previous.title}}</a>
    </span>
    {% endif %}
    {% if page.next.url %}
    <span class="col-lg-6 text-lg-end">
        <i class="bi bi-arrow-right float-lg-end mx-1" aria-hidden="true"></i>
        <a class="link-underline-secondary" href="{{page.next.url}}">{{page.next.title}}</a>
    </span>
    {% endif %}
</div>
{% endraw %}
{% endhighlight %}

Jekyll中的page变量用于访问页面(page)的相关信息,可以在Liquid模板中使用。

主要的page变量有:
- page.content - 页面内容
- page.title - 页面标题
- page.excerpt - 页面摘要
- page.url - 页面网址,不含域名
- page.date - 页面日期
- page.id - 页面唯一标识符
- page.categories - 页面所属分类
- page.collection - 页面所属的文档集合
- page.tags - 页面标签
- page.dir - 页面源文件相对源目录的路径
- page.name - 页面文件名
- page.path - 页面源文件的路径
- page.next - 下一篇页面
- page.previous - 上一篇页面

  这些变量可以用于访问页面的元数据,也可以用于模板中生成链接等内容。 熟悉这些page变量可以帮助我们更好地在Jekyll中使用页面数据和构建网站。

