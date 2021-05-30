import 'package:flutter/material.dart';
import 'package:kai_flutter_demo_module/test_page_1.dart';
import 'package:kai_flutter_demo_module/test_page_2.dart';
import 'package:kai_flutter_demo_module/test_page_3.dart';
import 'package:kai_flutter_demo_module/test_page_4.dart';
import 'package:kai_flutter_demo_module/test_page_5.dart';
import 'package:kai_flutter_demo_module/test_page_6.dart';
import 'package:kai_flutter_demo_module/test_page_7.dart';
import 'package:kai_flutter_demo_module/test_page_8.dart';
import 'package:kai_flutter_demo_module/test_page_9.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      ),
      routes: {
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        'test_page_1': (context) {
          //ModalRoute.of(context).settings.arguments
          return TestPage1(title: 'Test Page 01');
        },
        'test_page_2': (context) => TestPage2(),
        'test_page_3': (context) => TestPage3(),
        'test_page_4': (context) => TestPage4(),
        'test_page_5': (context) => TestPage5(),
        'test_page_6': (context) => TestPage6(),
        'test_page_7': (context) => TestPage7(),
        'test_page_8': (context) => TestPage8(),
        'test_page_9': (context) => TestPage9(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "test_page_1"),
              child: Text("test_page_1"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "test_page_2"),
              child: Text("test_page_2"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "test_page_3"),
              child: Text("test_page_3"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "test_page_4"),
              child: Text("test_page_4"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "test_page_5"),
              child: Text("test_page_5"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "test_page_6"),
              child: Text("test_page_6"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "test_page_7"),
              child: Text("test_page_7"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "test_page_8"),
              child: Text("test_page_8"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "test_page_9"),
              child: Text("test_page_9"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
