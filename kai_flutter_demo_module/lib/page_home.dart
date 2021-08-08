import 'package:flutter/material.dart';
import 'package:kai_flutter_demo_module/utils/kai_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'test_dart_syntax.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class EntryInfo {
  String title;
  String router;

  EntryInfo(this.title, this.router);
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;
  late AnimationController _controller;
  late CurvedAnimation _curve;
  List<EntryInfo> _EntryInfoList = [
    EntryInfo("Stack Positioned", "/test_page_1"),
    EntryInfo("BoxDecoration Shadow Transform", "test_page_2"),
    EntryInfo("Drawer BottomNavigationBar TabBarView", "test_page_3"),
    EntryInfo("CircularNotchedRectangle FloatingActionButtonLocation", "test_page_4"),
    EntryInfo("InheritedWidget", "test_page_5"),
    EntryInfo("Theme Test", "test_page_6"),
    EntryInfo("Dialog", "test_page_7"),
    EntryInfo("Touch Listener Gesture", "test_page_8"),
    EntryInfo("Provider Counter", "/provider_counter_page"),
    EntryInfo("Provider Shopper", "/provider_shopper_page_login"),
    EntryInfo("test9", "test_page_9"),
  ];

  @override
  void dispose() {
    savePressedCount();
    super.dispose();
  }

  void savePressedCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('savePressedCount save main $_counter times.');
    await prefs.setInt('main_counter', _counter);
  }

  void readPressedCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('readPressedCount Pressed $_counter times.');
    setState(() {
      _counter = (prefs.getInt('main_counter') ?? 0) + 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..value = 0.5;
    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    readPressedCount();
  }

  void _incrementCounter() {
    _controller.forward();
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
        title: Text(widget.title!),
        actions: [
          IconButton(
            icon: Icon(Icons.restaurant_menu),
            onPressed: () {
              syntaxMain();
            },
          )
        ],
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
            FadeTransition(
                opacity: _curve,
                child: Text(
                  'You have pushed the button this many times:',
                )),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            // NotificationListener<KaiNotification>(
            NotificationListener(
              onNotification: (dynamic notification) {
                switch (notification.runtimeType) {
                  case ScrollStartNotification:
                    print("开始滚动");
                    break;
                  case ScrollUpdateNotification:
                    // print("正在滚动");
                    break;
                  case ScrollEndNotification:
                    print("滚动停止");
                    break;
                  case OverscrollNotification:
                    print("滚动到边界");
                    break;
                  case KaiNotification:
                    {
                      KaiNotification notify = notification;
                      print("KaiNotification:" + notify.msg);
                    }
                    break;
                }
                return false;
              },
              child: Expanded(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    EntryInfo info = _EntryInfoList[index];
                    return ListTile(
                      title: Text(info.title),
                      trailing: Text(
                        info.router,
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () async {
                        KaiNotification("Click List Item _ " + info.title).dispatch(context);
                        // Navigator.pushNamed(context, info.router, arguments: info.title);
                        navigatorPush(context, info.router, arguments: {'title': info.title});
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 1,
                      thickness: 1,
                      indent: 12,
                      endIndent: 12,
                      color: Colors.green,
                    );
                  },
                  itemCount: _EntryInfoList.length,
                ),
              ),
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

class KaiNotification extends Notification {
  KaiNotification(this.msg);

  final String msg;
}
