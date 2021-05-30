import 'package:flutter/material.dart';

class TestPage9 extends StatefulWidget {
  TestPage9({Key key, this.title = "TestPage9"}) : super(key: key);
  final String title;

  @override
  _TestPage9State createState() => _TestPage9State();
}

class _TestPage9State extends State<TestPage9> {
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
