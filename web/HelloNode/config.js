// 监听的端口
var port = 3000;
// 项目配置
var projects = {
    mall: {
        path: '/data/www',
        url: 'git@git.coding.net:Click_04/mall.git'
    },
    lib: {
        path: '/storage',
        url: 'git@git.coding.net:Click_04/lib.git'
    },
    // 更多的项目...
};
// 数据库配置
var db = {
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'webhook'
};
module.exports = {
    projects: projects,
    port: port,
    db: db
};