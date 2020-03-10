
/**
 * Dart 是一个面向对象编程语言，同时支持基于 mixin 的继承机制。
 * 
 * 每个对象都是一个类的实例，所有的类都继承于 Object。 
 * 基于 Mixin 的继承意味着每个类（Object 除外） 都只有一个超类，
 * 一个类的代码可以在其他多个类继承中重复使用。
 * 
 * 
 * Use extends to create a subclass, and super to refer to the superclass
 * A class implements one or more interfaces by declaring them in an implements clause 
 * and then providing the APIs required by the interfaces.
 */

void testObject() {

  // var obj = new Point(10, 20);
  var obj = KDPoint.fromJson({'x':10, 'y':20.0});
  print(obj.toString());

  var rect = new KDRectangle(0, 50, 100, 100);
  assert(rect.right == 100);
  assert(rect.bottom == 150);

  var person = new Person();
  person.fullName;
  // person._name; // error
  // person._method3();
  // optional 可能为 null
  person?.fullName;

  // 创建一个常量对象
  // var person1 = const Person(); 

  var woman = Woman();
  print(woman.gender());


  var man = Man();
  print(man.gender());
}

class KDPoint {
  // 每个变量会自动生成 getter， 可变变量会自动生成 setter
  int x;
  double y;
  final num z = 30; // 默认值

  // getter
  num get sum => x + y;

  // setter
  set right(num value) => y = value;

  /**
   * Default constructors（默认构造函数，没有参数）
   * 
   * Consructor
   */ 
  KDPoint(int x, double y) {
    this.x = x;
    this.y = y;
  }

  // Redirecting constructors 使用已定义好的构造函数
  KDPoint.alongXAxis(int x): this(x, 0);

  // Named constructor 实现多个构造函数
  KDPoint.fromJson(Map json) {
    x = json['x'];
    y = json['y'];
  }

  // Overridable operators（可覆写的操作符）
  KDPoint operator +(KDPoint p) {
    return new KDPoint(x + p.x, y + p.y);
  }

  /**
   * Methods
   * 
   * instance mathod 中可以使用 instance var 和 this 关键字
   * 
   */
  String toString() {
    return '$x, $y, $z';
  }
}

class KDRectangle {
  num left, top;
  num width, height;

  // 初始话的简便写法
  KDRectangle(this.left, this.top, this.width, this.height);

  // getter setter
  num get right             => left + width;
      set right(num right)  => left = right - width;

  num get bottom              => top + height;
      set bottom(num bottom)  => top = bottom - height;
}

class Person {
  // 下划线开头定义的是 private 的变量
  // 以下划线 (_) 开头的标识符只有在库内部可见
  String _name;
  String fullName;

  // 类变量(静态变量) 在第一次使用时被初始化
  static const TAG = 'Person';

  void method1() {
    //
  }

  void method2() {
    //
  }

  // 下划线开头 实例对象不可使用
  // 以下划线 (_) 开头的标识符只有在库 内部可见
  void _method3() {
    //
  }

  // 类函数(静态函数)
  // 对于通用的或者经常使用的静态函数，考虑 使用顶级方法而不是静态函数
  static void testStatic() {
    //
  }

  String gender() {
    return "person";
  }
}

// 单继承
class Man extends Person {

  @override
  void method2() {
    super.method2();  // 使用 super 引用父类的方法
    print("重载了 method2");
    method1();
    
    // 私有的变量在父类可被看到
    _method3();
    _name;
  }
}

// 抽象类，用于定义接口。 不可以实例化，只能被继承，子类被实例化。
abstract class AbstractClass {
  var name;
  void sayHello();
}

/**
 * To implement a mixin, 
 * create a class that extends Object and declares no constructors. 
 * Unless you want your mixin to be usable as a regular class, 
 * use the mixin keyword instead of class.
 * 
 * 没有 constructor
 * 
 */
mixin Gender {
  String gender() {
    return "gender";
  }
}

/**
 * mixins
 * 为类添加新的功能(有点 组合 的意思)
 * Mixins are a way of reusing a class’s code in multiple class hierarchies.
 * 
 * 在 with 后添加 n 个 mixins
 * 
 * 
 */
class Woman extends Person with AbstractClass, Gender {
  
  @override
  void sayHello() {
    print("say hello");
  }

  //@override
  String gender() {
    return super.gender();
  }
}

