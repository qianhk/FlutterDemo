import 'package:flutter/material.dart';

class TestPage6 extends StatefulWidget {
  TestPage6({Key key, this.title = "TestPage6"}) : super(key: key);
  final String title;

  @override
  _TestPage6State createState() => _TestPage6State();
}

class _TestPage6State extends State<TestPage6> {
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
