import 'package:flutter/material.dart';
// import 'package:flutter_boost/flutter_boost.dart';

Future<T?> navigatorPush<T extends Object>(BuildContext context, String pageName, {Object? arguments}) {
  return Navigator.pushNamed<T>(context, pageName, arguments: arguments);
  // Navigator.push(context, MaterialPageRoute(builder: (context) => MyCart()));
  // BoostNavigator.instance.push(pageName);
}

Future<T?> navigatorPushReplacement<T extends Object, TO extends Object?>(BuildContext context, String pageName, {Object? arguments}) {
  return Navigator.pushReplacementNamed<T, TO>(context, pageName, arguments: arguments);
// Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyCatalog()));
  // BoostNavigator.instance.pushReplacement('/provider_shopper_page_catalog');
}

void navigatorPop<T extends Object>(BuildContext context, [T? result]) {
  return Navigator.pop<T>(context, result);
  //BoostNavigator.instance.pop();
}
