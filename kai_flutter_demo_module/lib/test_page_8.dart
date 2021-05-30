import 'package:flutter/material.dart';

class TestPage8 extends StatefulWidget {
  TestPage8({Key key, this.title = "TestPage8"}) : super(key: key);
  final String title;

  @override
  _TestPage8State createState() => _TestPage8State();
}

class _TestPage8State extends State<TestPage8> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Text:',
            ),
          ],
        ),
      ),
    );
  }
}
