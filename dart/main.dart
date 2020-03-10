
// 使用 import 来指定一个库如何使用另外一个库
// 对于内置的库，URI 使用特殊的 dart: scheme 
// 对于其他的库，你可以使用文件系统路径或者 package: scheme 
// package: scheme 指定的库通过包管理器来提供， 例如 pub 工具
import 'global_test.dart';
import 'object.dart';
import 'enum.dart';
import 'collection.dart';

// 引入系统内置库
import 'dart:math';
import 'dart:io';

// 引用第三方库
// import 'package:http/http.dart';

void main() {
  globalTest();
  // _methodPrivate(); // error
  
  // testObject();
  // testEnum();
  // testCollection();
}