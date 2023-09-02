---
title: Jekyll下载Gravatar头像到本地
category: ruby
date: '2023-09-02 01:30:00'
tags: jekyll gravatar
---

## 关于Gravatar的问题

由于网络问题，Gravatar的头像往往无法访问

> Gravatar（英语：Globally Recognized Avatar）是一项用于提供在全球范围内使用的头像服务。只要你在Gravatar的服务器上上传了你自己的头像，你便可以在其他任何支持Gravatar的博客、论坛等地方使用它。

如果你也喜欢用Gravatar，可以到网上搜索国内镜像处理来解决这个问题，或者用自己的服务器做反向代理，也可以用静态文件存储服务做资源回源。

下面是第3种方案，因为Github Actions运行的服务器是网络没问题，所以可以利用Github Action来下载Gravatar到本地。

## 使用方式

{% highlight html linenos%}
{% raw %}
读取变量方式
<img src="{% gravatar_url email:site.email, extension:png, size:128 %}" class="rounded-circle" style="width: 128px;" alt="程序员阿辉的头像" />

或者直接使用邮箱

<img src="{% gravatar_url email:runphp@qq.com, extension:png, size:128 %}" class="rounded-circle" style="width: 128px;" alt="程序员阿辉的头像" />
{% endraw %}
{% endhighlight %}

## 生成的代码
```html
<img src="/avatar/01bd973af4f116ec5f5c76d65983c639-128.png" class="rounded-circle" style="width: 128px;" alt="程序员阿辉的头像" />
```
标签有3个属性，分别是email, extension,  size和Gravatar api对应。

## 实现代码如下

```ruby
require 'digest/md5'
require "open-uri"

module Jekyll
  class GravatarUrl < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @attributes = text.scan(::Liquid::TagAttributes).to_h
    end

    def render(context)
      email = @attributes['email']
      if email !~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i and email =~ /([\w]+(\.[\w]+)*)/i
        email = look_up(context, $1)
      end
      hash = Digest::MD5.hexdigest(email.downcase.strip)
      extension = @attributes['extension']
      size = @attributes['size']
      gravatar_url = "https://gravatar.com/avatar/#{hash}.#{extension}?s=#{size}"
      save_path = "_site/avatar/#{hash}-#{size}.#{extension}"
      local_url = "/avatar/#{hash}-#{size}.#{extension}"
      return local_url if File.exist?(save_path)
      # download gravatar
      begin
        file = URI.open(gravatar_url)
      rescue => e
        Jekyll.logger.warn e
        return gravatar_url
      end
      FileUtils.mkdir_p(File.dirname(save_path))
      IO.copy_stream(file, save_path)
      local_url
    end

    def look_up(context, name)
      lookup = context
      name.split(".").each do |value|
        lookup = lookup[value]
      end
      lookup
    end

    Liquid::Template.register_tag('gravatar_url', self)
  end
end
```