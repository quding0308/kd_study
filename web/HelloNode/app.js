// var express = require('express');
// var app = express();

// app.get('/', function (req, res) {
//   res.send('Hello World!222');
// });

// app.listen(3000, function () {
//   console.log('Example app listening on port 3000!');
// });


var http = require('http');
var config = require('./config.js');
var server = http.createServer(function (req, res) {
    // 接收 POST 数据。如果请求方法不是 POST，那么这个变量最终是空字符串
    var POST = '';
    req.on('data', function (chunk) { POST += chunk;});
    req.on('end', function () {
        // 执行后端逻辑代码
    });
});
server.listen(config.port);
console.log("Server runing at port: " + config.port + ".");
/**
 * 
  res.setHeader('Content-Type', 'text/plain');

  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader("Access-Control-Allow-Methods", "*");  
  res.setHeader("Access-Control-Allow-Headers", "Content-Type,XFILENAME,XFILECATEGORY,XFILESIZE");  

  // 设置了Cache-Control后，会保存在客户端，如果缓存没过期，则直接加载本地（如果有新资源，则无法更新到最新资源）
  res.setHeader("Cache-Control", "public, max-age=31536000");

 */