## 关于此项目

这个项目是我的个人博客，用于记录学习、工作、生活中的所见所思,
使用Jekyll搭建，通过Github Actions进行部署，存储在Github pages

> 访问地址: <https://blog.runphp.net>

> 源代码: <https://github.com/runphp/blog.runphp.net>

### 本地运行
1. 确保已经安装Ruby和Nodejs
2. 运行`npm install` 安装前端依赖包
3. 运行`bundle install` 安装Jekyll以及依赖插件
4. 运行`bundle exec jekyll s` 启动web服务
5. 访问`http://localhost:4000` 访问网站
6. 访问`http://localhost:4000/admin` 访问管理后台

### 部署到Github Pages
配置好Github Actions即可，在push代码的时候会自动运行workflow
流程如下：
1. 安装node环境
2. 安装前端依赖包
3. 安装Ruby
4. installed gems
5. 部署代码到Github Pages

请参考文件`.github/workflows/jekyll.yml`

### 感谢以下软件或服务

| 软件或服务      | 网址                                        | 说明                                                         |
| --------------- |-------------------------------------------| ------------------------------------------------------------ |
| Jekyll          | <https://jekyllrb.com>                  | 将纯文本转换为静态博客网站                                   |
| Github Actions  | <https://github.com/features/actions>      | 可让您轻松自动化所有软件工作流程                             |
| Bootstrap       | <https://getbootstrap.com>                 | 功能强大、可扩展且功能丰富的前端工具包                       |
| Bootstrap Icons | <https://icons.getbootstrap.com>           | Bootstrap 免费、高质量、开源图标库                           |
| Ruby            | <https://www.ruby-lang.org>                | Ruby 是一种面向对象、指令式、函数式、动态的通用编程语言      |
| Node.js         | <https://nodejs.org>                       | Node.js 是能够在服务器端运行 JavaScript 的开放源代码、跨平台执行环境 |
| Npm             | <https://www.npmjs.com>                    | npm（全称 Node Package Manager，即“node包管理器”）是Node.js默认的、用JavaScript编写的软件包管理系统 |
| Liquid          | <https://github.com/Shopify/liquid>        | Shopify的Liquid模板引擎，面向客户端的安全模板语言，适用于灵活的 Web 应用 |
| jekyll-feed     | <https://github.com/jekyll/jekyll-feed>    | 一个 Jekyll 插件，用于生成您的 Jekyll 帖子的 Atom（类似 RSS）提要 |
| jekyll-seo-tag  | <https://github.com/jekyll/jekyll-seo-tag> | 一个 Jekyll 插件，用于为搜索引擎和社交网络添加元数据标签，以更好地索引和显示您网站的内容 |
| jekyll-archives | <https://github.com/jekyll/jekyll-archives> | 为您的 Jekyll 标签和类别存档页面                             |
| jekyll-sitemap  | <https://github.com/jekyll/jekyll-sitemap> | Jekyll 插件为您的 Jekyll 网站静默生成符合 sitemaps.org 的站点地图 |
| jekyll-admin    | <https://github.com/jekyll/jekyll-admin>   | 一个 Jekyll 插件，为用户提供传统的 CMS 风格的图形界面来创作内容和管理 Jekyll 网站 |
| jekyll-toc      | <https://github.com/toshimaru/jekyll-toc>  | 可以为文章生成目录（table of contents）的一个Jekyll插件      |
| Gravatar        | <https://gravatar.com>                     | Gravatar是一项用于提供在全球范围内使用的头像服务。只要你在Gravatar的服务器上上传了你自己的头像，你便可以在其他任何支持Gravatar的博客、论坛等地方使用它 |
| Gitalk          | <https://github.com/gitalk/gitalk>         | Gitalk是一个基于Github issue和Preact的现代评论组件           |
{: class="table table-bordered table-hover"}

