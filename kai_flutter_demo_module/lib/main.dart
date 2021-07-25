import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:kai_flutter_demo_module/test_page_1.dart';
import 'package:kai_flutter_demo_module/test_page_2.dart';
import 'package:kai_flutter_demo_module/test_page_3.dart';
import 'package:kai_flutter_demo_module/test_page_4.dart';
import 'package:kai_flutter_demo_module/test_page_5.dart' as TestCustomProvider;
import 'package:kai_flutter_demo_module/test_page_6.dart';
import 'package:kai_flutter_demo_module/test_page_7.dart';
import 'package:kai_flutter_demo_module/test_page_8.dart';
import 'package:kai_flutter_demo_module/test_page_9.dart';
import 'package:provider/provider.dart';

import 'dialog_page.dart';
import 'provider_counter/provider_counter_main.dart';
import 'provider_shopper/screens/login.dart' as Shopper;
import 'provider_shopper/screens/catalog.dart' as Shopper;
import 'provider_shopper/screens/cart.dart' as Shopper;
import 'provider_shopper/models/cart.dart' as Shopper;
import 'provider_shopper/models/catalog.dart' as Shopper;

import 'page_home.dart';

class CustomFlutterBinding extends WidgetsFlutterBinding with BoostFlutterBinding {}

void main() {
  CustomFlutterBinding();
  runApp(MyApp());
}

void main2() => runApp(Stack(
      fit: StackFit.expand,
      children: [
        MyApp(),
        Positioned(
          left: 0,
          bottom: 0,
          width: 200,
          child: CircleAvatar(
            child: Image.asset('assets/images/hsfengjing.jpg'),
          ),
        )
      ],
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static Map<String, FlutterBoostRouteFactory> routerMap = {
    '/home': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) {
            var argMap = settings.arguments as Map<String, dynamic>;
            return MyHomePage(title: argMap['title'] ?? 'Flutter Demo Home Page');
          });
    },
    '/test_page_1': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(settings: settings, pageBuilder: (_, __, ___) => TestPage1(title: 'Test Page 01'));
    },
    'test_page_2': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(settings: settings, pageBuilder: (_, __, ___) => TestPage2());
    },
    'test_page_3': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(settings: settings, pageBuilder: (_, __, ___) => TestPage3());
    },
    'test_page_4': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(settings: settings, pageBuilder: (_, __, ___) => TestPage4());
    },
    'test_page_5': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(settings: settings, pageBuilder: (_, __, ___) => TestCustomProvider.TestPage5());
    },
    'test_page_6': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(settings: settings, pageBuilder: (_, __, ___) => TestPage6());
    },
    'test_page_7': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(settings: settings, pageBuilder: (_, __, ___) => TestPage7());
    },
    'test_page_8': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) => TestPage8(
                title: (settings.arguments as Map)['title'],
              ));
    },
    'test_page_9': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(settings: settings, pageBuilder: (_, __, ___) => TestPage9());
    },
    '/provider_counter_page': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) => ProviderCounterPage(
                title: (settings.arguments as Map)['title'],
              ));
    },
    '/provider_shopper_page_login': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(settings: settings, pageBuilder: (_, __, ___) => Shopper.MyLogin());
    },
    '/provider_shopper_page_catalog': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(settings: settings, pageBuilder: (_, __, ___) => Shopper.MyCatalog());
    },
    '/provider_shopper_page_cart': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(settings: settings, pageBuilder: (_, __, ___) => Shopper.MyCart());
    },
    '/dialogPage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
        opaque: false,
        barrierColor: Colors.green,
        settings: settings,
        pageBuilder: (_, __, ___) => DialogPage(),
      );
    },
  };

  Route<dynamic> routeFactory(RouteSettings settings, String uniqueId) {
    FlutterBoostRouteFactory func = routerMap[settings.name];
    if (func == null) {
      return null;
    }
    return func(settings, uniqueId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Shopper.CatalogModel()),
        ChangeNotifierProxyProvider<Shopper.CatalogModel, Shopper.CartModel>(
          create: (context) => Shopper.CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: FlutterBoostApp(routeFactory),
    );
  }

  Widget build2(BuildContext context) {
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => Shopper.CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<Shopper.CatalogModel, Shopper.CartModel>(
          create: (context) => Shopper.CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
          primarySwatch: Colors.blue,
          // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        routes: {
          '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
          '/test_page_1': (context) {
            //ModalRoute.of(context).settings.arguments
            return TestPage1(title: 'Test Page 01');
          },
          'test_page_2': (context) => TestPage2(),
          'test_page_3': (context) => TestPage3(),
          'test_page_4': (context) => TestPage4(),
          'test_page_5': (context) => TestCustomProvider.TestPage5(),
          'test_page_6': (context) => TestPage6(),
          'test_page_7': (context) => TestPage7(),
          'test_page_8': (context) => TestPage8(title: ModalRoute.of(context).settings.arguments),
          'test_page_9': (context) => TestPage9(),
          '/provider_counter_page': (context) => ProviderCounterPage(),
          '/provider_shopper_page': (context) => Shopper.MyLogin(),
        },
      ),
    );
  }
}
