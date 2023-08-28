---
layout: post
title:  "Sass介绍"
author: runphp
date:   2023-08-17 17:02:18 +0800
category: english
tags: sass
toc: true
---

## What is Sass?（Sass是什么?）

- **Sass** 全称 **Syntactically Awesome Stylesheet (语法完全绝妙的样式)**
- Sass 是 CSS 的扩展 (Sass is an extension to CSS)
- Sass 是一种 CSS 预处理器 (Sass is a CSS pre-processor)
- Sass 与所有版本的 CSS 完全兼容 (Sass is completely compatible with all versions of CSS)
- Sass 通过减少 CSS 的重复代码,来节省时间 (Sass reduces repetition of CSS and therefore saves time)
- Sass 由 Hampton Catlin 设计,Natalie Weizenbaum 在2006年开发 (Sass was designed by Hampton Catlin and developed by Natalie Weizenbaum in 2006)
- Sass 是完全免费下载和使用的 (Sass is free to download and use)

## 为什么要使用 Sass? (Why Use Sass?)

- 样式表变得越来越大,越来越复杂,也越来越难维护。这时一个 CSS 预处理器就可以提供帮助。(Stylesheets are getting larger, more complex, and harder to maintain. This is where a CSS pre-processor can help.)
- Sass 允许你使用 CSS 中不存在的特性,像变量,嵌套规则,混入,导入,继承,内置函数等等。(Sass lets you use features that do not exist in CSS, like variables, nested rules, mixins, imports, inheritance, built-in functions, and other stuff.)

## How Does Sass Work? （Sass是如何工作的？）

A browser does not understand Sass code. Therefore, you will need a Sass pre-processor to convert Sass code into standard CSS.

浏览器不理解Sass代码。因此，您将需要一个Sass预处理器来将Sass代码转换为标准CSS。


This process is called transpiling. So, you need to give a transpiler (some kind of program) some Sass code and then get some CSS code back.

这个过程被称为transpiling。所以，你需要给一个transpiler（某种程序）一些Sass代码，然后得到一些CSS代码。

Transpiling is a term for taking a source code written in one language and transform/translate it into another language.
Transpilling是指将用一种语言编写的源代码转换/翻译成另一种语言。

我觉得transpiling可以翻译为`转译`

## Transpiling Sass to CSS （将Sass转换为CSS）

Sass code needs to be transpiled into CSS code in order to be used in websites.

Sass代码需要转换成CSS代码才能在网站中使用。

This process is called **transpiling**.

这个过程被称为**转译**。

Transpiling converts the Sass syntax into regular CSS syntax.

Transpilling将Sass语法转换为常规CSS语法。

To transpile Sass, you need a **transpiler program**:

要转译Sass，您需要一个**转译程序**：

The most popular transpiler for Sass is sass which is part of the Dart Sass project.

Sass最受欢迎的转发器是Sass，它是`Dart-Sass`项目的一部分。

Other options include node-sass and ruby-sass.

其他选项包括`node-sas`和`ruby-sas`。

The transpiler takes Sass code as input and generates CSS code as output that can be used directly in projects.

transiler将Sass代码作为输入，并生成可直接用于项目的CSS代码作为输出。

For example:

scss
```scss
// Input
$color: red;

.box {
  color: $color;
}
```

css
```css
css
/* Output */
.box {
    color: red;
}
```
