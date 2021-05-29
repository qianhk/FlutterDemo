import 'package:flutter/material.dart';

class TestPage4 extends StatefulWidget {
  TestPage4({Key key, this.title = "TestPage4"}) : super(key: key);
  final String title;

  @override
  _TestPage4State createState() => _TestPage4State();
}

class _TestPage4State extends State<TestPage4> {
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
