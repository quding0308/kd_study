var express = require('express');
var app = express();

app.get('/', function (req, res) {
  res.send('Hello World!222');
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});

/**
 * 
  res.setHeader('Content-Type', 'text/plain');

  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader("Access-Control-Allow-Methods", "*");  
  res.setHeader("Access-Control-Allow-Headers", "Content-Type,XFILENAME,XFILECATEGORY,XFILESIZE");  

  // 设置了Cache-Control后，会保存在客户端，如果缓存没过期，则直接加载本地（如果有新资源，则无法更新到最新资源）
  res.setHeader("Cache-Control", "public, max-age=31536000");

 */