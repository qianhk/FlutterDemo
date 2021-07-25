import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderCounterPage extends StatefulWidget {
  final String title;
  const ProviderCounterPage({Key key, this.title}) : super(key: key);

  @override
  _ProviderCounterPageState createState() => _ProviderCounterPageState();
}

class _ProviderCounterPageState extends State<ProviderCounterPage> {
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
