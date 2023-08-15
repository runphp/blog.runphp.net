---
layout: post
title:  "Jekyll判断标签是最后一个"
author: runphp
date:   2023-08-15 11:45:06 +0800
category: other
tags: Jekyll
---

使用forloop.last进行判断即可
示例如下：
{% highlight html linenos%}
{% raw %}
{% if page.tags.size > 0 %}
<div>
  <i class="bi bi-tags" aria-hidden="true"></i>
    {% for tag in page.tags %}
      <i class="p-1 text-info-emphasis bg-info-subtle border border-primary-subtle rounded-1">{{ tag }}</i>
      {% if forloop.last %}{% else %},{% endif %}
    {% endfor %}
</div>
{% endif %}
{% endraw %}
{% endhighlight %}