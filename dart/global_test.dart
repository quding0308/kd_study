/**
Object
  - num
    - int
    - double
  - null
  - Function
  - String
  - bool


 */

int a = 1;
int b = 2;
int c;
double d = null;
num _paramPrivate = 20;
Object obj = null;
bool flag = false;

var param = '123';
var param1 = null;

final int param3 = 10;


/**
 * Function 也是 object
 * Dart is a true object-oriented language, so even functions are objects and have a type, Function. 
 * This means that functions can be assigned to variables or passed as arguments to other functions.
 */
int sum(int x, int y) {
  return x + y;
}

typedef Sum1 = int Function(int, int);

void loop() {
  var arr = [1, 2, 3, 4, 5];

  print(arr);
  
  for (var item in arr) {
    print(item);
  }

  for (int i=0; i<arr.length; i++) {
    print(arr[i]);
  }

  int j = 0;
  while (j < arr.length) {
    print(arr[j]);
    j = j + 1;
  }

  if (a < b) {
    print(a<b);
  }

}

void _methodPrivate() {
  //
}

void globalTest() {
  print('globalTest' + ' 123');
  print(c);
  print(sum(a, b));

  bool flag = true; // false

  Sum1 sum1 = sum;

  var result = sum1(1, 2);

  // 匿名函数  可以理解为 closure
  var funcSum = (int a, int b) {
    return a + b;
  };
  print(funcSum(5, 9));

  // 语法糖 只有一行语句
  // var sum2 = (int a, int b) => print(a + b);
  // print(sum2(9, 9));

  // is 判断类型
  print(obj is Object);
  print(flag is Object);
  print(_paramPrivate is Object);
  // Function 也是 Object
  print(_methodPrivate is Object);

  // 会报错， 静态类型语言，会自动根据初始化的值推导类型
  // param = 123;
  param1 = 123;
  param1 = '234';
  // loop();
}