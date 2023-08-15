---
layout: post
title:  "Jekyll判断标签是最后一个"
author: runphp
date:   2023-08-15 11:45:06 +0800
category: ruby
tags: jekyll
---

使用forloop.last进行判断即可, 示例如下：
{% highlight html linenos%}
{% raw %}
{% if page.tags.size > 0 %}
<div>
  <i class="bi bi-tags" aria-hidden="true"></i>
    {% for tag in page.tags %}
      <i class="p-1 text-info-emphasis bg-info-subtle border border-primary-subtle rounded-1">{{ tag }}</i>
      {% unless forloop.last %},{% endunless %}
    {% endfor %}
</div>
{% endif %}
{% endraw %}
{% endhighlight %}

### forloop (属性)

|   Property   |                         Description                          |  Returns  |
| :----------: | :----------------------------------------------------------: | :-------: |
|   `length`   |         The total number of iterations in the loop.          | `number`  |
| `parentloop` | The parent `forloop` object. If the current `for` loop isn’t nested inside another `for` loop, then `nil` is returned. | `forloop` |
|   `index`    |         The 1-based index of the current iteration.          | `number`  |
|   `index0`   |         The 0-based index of the current iteration.          | `number`  |
|   `rindex`   | The 1-based index of the current iteration, in reverse order. | `number`  |
|  `rindex0`   | The 0-based index of the current iteration, in reverse order. | `number`  |
|   `first`    | Returns `true` if the current iteration is the first. Returns `false` if not. | `boolean` |
|    `last`    | Returns `true` if the current iteration is the last. Returns `false` if not. | `boolean` |
{: class="table table-bordered table-hover"}