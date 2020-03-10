
api地址：

https://api.dartlang.org/stable/dart-core/List-class.html


flutter 介绍：
https://book.flutterchina.club/chapter1/flutter_intro.html

## 语言特性

- 单个文件作为 模块 吗？怎么引用？
- if 、for、while、switch 跟 js 保持一致？
- 
- 面向对象的语言，但是还可以写全局的函数、变量。意味着，同时支持 面向对象、面向过程 两种模式

### 面向对象

- 定义类
- 变量
- 方法
- 构造器、deinit
- 实例化

### 变量

没有初始化的变量为 null

### final const

一个 final 变量只能赋值一次；一个 const 变量是编译时常量。 （const 变量同时也是 final 变量。） 顶级的 final 变量或者类中的 final 变量在 第一次使用的时候初始化。

实例变量可以为 final 但是不能是 const 。


static 用于修饰类成员变量，类比 java 中的使用
final 用于修饰变量，在变量声明时，必须被初始化，并且之后不能在赋值
const 修饰值 表示在编译期间就可以确定值，并且不可改
    var list = const [1, 2, 3];
    var point = const new Poinst(2, 3);

const 修饰 Constructor


### 字符串

字符串字面量是编译时常量

### 函数

顶级函数、类实例方法、类静态方法

闭包，函数简写

### 限定符

private public protected ？

和 Java 不同的是，Dart 没有 public、 protected、 和 private 关键字。如果一个标识符以 (_) 开头，则该标识符 在库内是私有的。

### Collection 集合

文档地址：

https://api.dartlang.org/stable/dart-core/List-class.html


### 字符串操作

### dart 包管理器：
https://pub.dev/

```
flutter pub get
```


### 重要概念

- 所有能使用变量引用的都是对象。数字、函数、null 都是对象
- dart 支持 顶级函数 和 顶级变量



## flutter

- 如何写widge 或 service 插件？
- 整体的运行流程是？与 iOS 端对比理解










