# blog.runphp.net

该博客部署在github上但是也可以通过docker进行部署

windows示例
```
docker run -t --rm -v d:/workspace/php/blog.runphp.net:/usr/src/app -p "4000:4000" -d --name=github-pages starefossen/github-pages
```

访问地址 <http://localhost:4000>
