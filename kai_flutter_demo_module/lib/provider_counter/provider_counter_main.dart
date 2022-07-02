import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProviderCounterPage extends StatefulWidget {
  final String title;
  const ProviderCounterPage({Key key, this.title}) : super(key: key);

  @override
  _ProviderCounterPageState createState() => _ProviderCounterPageState();
}

class _ProviderCounterPageState extends State<ProviderCounterPage> {
  void testHttpRequest() async {
    String testUrl = 'https://baidu.com';
    print('lookKai testHttpRequest url=$testUrl');
    http.Response response = await http.get(Uri.parse(testUrl));
    print('lookKai testHttpRequest response=${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Counter>(
        create: (context) => Counter(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title ?? 'ProviderCounter'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Kai have pushed the button this many times:'),
                Consumer<Counter>(
                  builder: (context, counter, child) => Text(
                    '${counter.value}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              onPressed: () {
                var counter = context.read<Counter>();
                counter.increment();
                testHttpRequest();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
        ));
  }
}

class Counter with ChangeNotifier {
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();
  }
}
