var app = new Vue({ 
    el: '#app',
    data: {
        message: 'Hello Vue!'
    }
});

var app2= new Vue({
    el: '#app-2',
    data: {
        message: '页面加载于 ' + new Date().toLocaleString()
    }
});

var app3 = new Vue({
    el: '#app-3',
    data: {
        seen: true
    }
});

var app4 = new Vue({
    el: '#app-4',
    data: {
        seen: true,
        todos: [
            { text: 'a' },
            { text: 'b' },
            { text: 'c' },
            { text: 'd' },
        ]
    }
});

var app5 = new Vue({
    el: '#app-5',
    data: {
        message: '日期',
    },
    methods: {
        reverseMessage: function(){
            this.message = new Date().toLocaleString();
        }
    }
});

var app6 = new Vue({
    el: '#app-6',
    data: {
        message: 'Hello'
    }
});

// 组件
Vue.component('todo-item', {
    props: ['todo'],
    template: '<li>{{ todo.text }}</li>'
});
var app7 = new Vue({
    el: '#app-7',
    data: {
        list: [
            { id: 0, text: 'aa' },
            { id: 1, text: 'bb' },
            { id: 2, text: 'cc' },
            { id: 3, text: 'dd' }
        ]
    }
});

var gData = {
    message: '45678'
};
var app8 = new Vue({
    el:'#app-8',
    data: gData
});

var app9 = new Vue({
    el:'#app-9',
    data: gData
});

// 一个 Vue 实例
/**
var vm = new Vue({
    el: '#example',
    data: { // data中的值改变时，视图将会产生“响应”，后面加入的属性不支持响应式
        a: 1,
        b: {}
    },
    created: function() {   // 钩子 创建之后被执行
        console.log();
    },
    mounted: function() {
        //
    },
    updated: function() {
        //
    },
    destroyed: function() {
        //
    }
});
*/

// 通过 $ 获取Vue实例的属性和方法
// vm.$data === data;
// vm.$el === document.getElementById('example');





