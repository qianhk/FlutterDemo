import 'dart:convert';
import 'dart:io';
import 'provider_shopper/models/cart.dart' as Shopper;
import 'provider_shopper/models/catalog.dart' as Shopper;
import 'package:json_annotation/json_annotation.dart';

part 'test_dart_syntax.g.dart';

//省略常用的类变量+factory的工厂构造函数法

class Person {
  // 拥有常量构造方法的类中，所有的成员变量必须是final修饰
  final String name;
  final int age;

  // 一个类中只能有一个常量构造方法，命名构造方法也不行
  // const Person(this.name);
  const Person(this.name, this.age);
}

class Person2 {
  final String name;
  final int age;
  late String _innerName;

  Person2(this.name, this.age);

  String get innerName => _innerName + "Field";

  set innerName(String name) => _innerName = name;
}

Future<String> getNetworkData() {
  // 将耗时操作包裹到Future的回调函数中
  return Future<String>(() {
    sleep(Duration(seconds: 1));
    return "Hello kai";
    // throw Exception("error");
  });
}

class User {
  final String? name;
  final String? email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}

@JsonSerializable()
class Address {
  String? street;
  String? city;

  Address(this.street, this.city);

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable(explicitToJson: true)
class User2 {
  User2(this.id, this.name, this.email, this.isAdult, this.registrationDateMillis, this.address);

  @JsonKey(required: true)
  final int? id;

  final String? name;
  final String? email;

  @JsonKey(defaultValue: true)
  final bool isAdult;

  @JsonKey(name: 'date_millis')
  final int? registrationDateMillis;

  Address? address;

  factory User2.fromJson(Map<String, dynamic> json) => _$User2FromJson(json);

  Map<String, dynamic> toJson() => _$User2ToJson(this);
}

void testJson() {
  String jsonString = '{"id":1,"name":"John Smith","email":"john@example.com","date_millis":123456,'
      '"address":{"city":"ShangHai","street":"马当路"}}';
  Map<String, dynamic> userMap = jsonDecode(jsonString);
  print('1. Howdy, ${userMap['name']}! email=${userMap['email']}.');

  var user = User.fromJson(userMap);
  print('2. Howdy, ${user.name}! email=${user.email}.');

  String json = jsonEncode(user);
  print('3. ToJson = $json');

  var user2 = User2.fromJson(userMap);
  print('4. Howdy, ${user2.name}! email=${user2.isAdult} ${user2.address!.city}.');
  print('5. jsonEncode = ${jsonEncode(user2)}');
  print('6. ToJson = ${user2.toJson()}');
}

void unit_test() {
  // test('adding item increases total cost', () {
  //   final cart = Shopper.CartModel();
  //   final startingPrice = cart.totalPrice;
  //   cart.addListener(() {
  //     expect(cart.totalPrice, greaterThan(startingPrice));
  //   });
  //   cart.add(Shopper.Item('Dash'));
  // });
}

void syntaxMain() {
  print("------------- syntaxMain ---------------");
  var future = getNetworkData();
  future
      .then((value) => print(value)) // Hello lqr
      .catchError((err) => print(err))
      .whenComplete(() => print("执行完成")); // 不管成功与否都会执行

  // 用 const常量 去接收一个常量构造函数的结果，可以省略 const
  // const p1 = const Person("lqr", 18);
  const p1 = Person("lqr", 18);
  const p2 = Person("lqr", 18);
  print('Person 1 identical: ${identical(p1, p2)}'); // true

  // 如果用 var变量 去接收一个常量构造函数的结果，则这时省略的不是 const，而是 new！！
  var p11 = Person("lqr", 18); // ==> var p11 = new Person("lqr");
  var p22 = Person("lqr", 18);
  print('Person 2 identical: ${identical(p11, p22)}'); // false

  // 必须所有的属性值相同，对象才是同一个
  const p111 = Person("lqr", 18);
  const p222 = Person("lqr", 20);
  print('Person 3 identical: ${identical(p111, p222)}'); // false

  var pp2 = Person2("publicKai", 23);
  pp2.innerName = "innerKai";
  print("Person2 innerName=${pp2.innerName}");

  var man = SuperMan();
  man.eating();
  man.running();
  man.flying();
  print("Extension say=${pp2.name.sayHello()} *3=${pp2 * 3} size=${pp2.name.size}");

  unit_test();
  testJson();
}

class Animal {
  void eating() {
    print("动物吃东西");
  }

  void running() {
    print("动物running");
  }
}

mixin Runner {
  void running() {
    print("mixin running");
  }
}

mixin Flyer {
  void flying() {
    print("mixin flying");
  }
}

// Runner中的running()与Animal中的running()冲突，这时会发生覆盖，即SuperMan中的running()调用的是Runner的running()
class SuperMan extends Animal with Runner, Flyer {}

extension Person2Ext on Person2 {
  operator *(int count) {
    String result = "";
    for (var i = 0; i < count; i++) {
      result += this.name;
      if (i < count - 1) {
        result += '_';
      }
    }
    return result;
  }
}

extension StringExt on String {
  String sayHello() {
    return "hello $this";
  }

  int get size {
    return this.length;
  }
}
