---
title: 设置bootstrap-icons-font-dir
category: ruby
date: '2023-09-11 18:17:35'
tags: jekyll bootstrap bootstrap-icons
---

Jekyll用了bootstrap-icons样式往往找不到字体文件，可以自定义字体文件路径
```scss
$bootstrap-icons-font-dir: "/dist/fonts";
```

webpack安装`copy-webpack-plugin`
```
npm install copy-webpack-plugin --save-dev
```

设置`webpack.config.js`


```js

const path = require('path');
const CopyPlugin = require("copy-webpack-plugin");

module.exports = {
    mode: process.env.NODE_ENV,
    entry: {
        common: ['./js/common.js'],
    },
    output: {
        filename: '[name].js',
        path: path.resolve(__dirname, '_site/dist'),
    },
    plugins: [
        new CopyPlugin({
            patterns: [
                { from: "node_modules/gitalk/dist" },
                { from: "node_modules/bootstrap-icons/font/fonts", to: "fonts"}
            ],
        }),
    ],
};

```
