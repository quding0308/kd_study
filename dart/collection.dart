/**
 * Collection and Generic
 * 
 * 
 * 
 */

void testCollection() {
  // 集合字面量
  var names = <String>['Peter', 'Klay' , 'Tom'];
  var map = <String, String>{
    'key1': 'value1',
    'key2': 'value2'
  };

  print('$map');

  var list = new List<num>();
  list.addAll([1, 2, 3, 4, 5]);
  list.add(6);

  var set = new Set<num>.from(list);
  print(set);

  var ages = new Map<String, num>();
  ages['key1'] = 10;
  ages['key2'] = 30;
  print(ages);

}