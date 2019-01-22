const path = require('path');

// 执行的命令
//  webpack-demo npx webpack --config webpack.config.js

module.exports = {
  entry: './src/index.js',
  mode: 'development',  
//   mode: 'production',
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'dist')
  }
};