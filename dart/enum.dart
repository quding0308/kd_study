
/**
 * a special kind of class used to represent a fixed number of constant values.
 * 枚举类型从 0 开始
 * 
 */
enum Color {
    red,
    blue,
    yellow
}

void testEnum() {
  // print(Color.yellow);

  var aColor = Color.red;

  switch (aColor) {
    case Color.blue:
      print(aColor);
      break;
    case Color.red:
      print(aColor);
      break;
    default:
      print(aColor);
  }


}