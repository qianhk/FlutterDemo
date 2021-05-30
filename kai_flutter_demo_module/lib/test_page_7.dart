import 'package:flutter/material.dart';

class TestPage7 extends StatefulWidget {
  TestPage7({Key key, this.title = "TestPage7"}) : super(key: key);
  final String title;

  @override
  _TestPage7State createState() => _TestPage7State();
}

class _TestPage7State extends State<TestPage7> {
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
