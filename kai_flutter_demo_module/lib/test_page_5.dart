import 'package:flutter/material.dart';

class TestPage5 extends StatefulWidget {
  TestPage5({Key key, this.title = "TestPage5"}) : super(key: key);
  final String title;

  @override
  _TestPage5State createState() => _TestPage5State();
}

class _TestPage5State extends State<TestPage5> {
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
