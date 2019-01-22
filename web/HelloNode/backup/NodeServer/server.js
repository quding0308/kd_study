const http = require('http');

// const hostname = '127.0.0.1';
const hostname = '172.20.200.78'; // 可以使用自己的ip 来访问
// const hostname = '0.0.0.0'; // 可以使用自己的ip 或 localhost 来访问
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');

  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader("Access-Control-Allow-Methods", "*");  
  res.setHeader("Access-Control-Allow-Headers", "Content-Type,XFILENAME,XFILECATEGORY,XFILESIZE");  

  // 设置了Cache-Control后，会保存在客户端，如果缓存没过期，则直接加载本地（如果有新资源，则无法更新到最新资源）
  res.setHeader("Cache-Control", "public, max-age=31536000");

  res.end('Hello World!111\n');
});

server.listen(port, hostname, () => {
  console.log(`服务器运行在 http://${hostname}:${port}/`);
});