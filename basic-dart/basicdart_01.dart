void main() {
  dynamic myList = ['1'];

  print("====================");
  
  
  String digits = "0123456789";
  print(digits.split(""));
  
  var a = 5;
  dynamic b = 5;
  Object c = 5;
  
  print('a : $a is ${a.runtimeType}');
  print('a : $b is ${b.runtimeType}');
  print('a : $c is ${c.runtimeType}');
  
  var myList1 = [];
  List<String> myList2 = [];
  
  List<String> myList3  = List.filled(3,'String');
  print(myList3);
  
  
}
