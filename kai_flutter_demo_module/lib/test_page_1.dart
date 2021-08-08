import 'package:flutter/material.dart';

class TestPage1 extends StatefulWidget {
  TestPage1({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _TestPage1State createState() => _TestPage1State();
}

class _TestPage1State extends State<TestPage1> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: <Widget>[
          UnconstrainedBox(
              child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation(Colors.white70),
                    ),
                  )))
        ],
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.bottomRight, //指定未定位或部分定位widget的对齐方式
          children: <Widget>[
            Positioned(
              child: Container(
                child: Text("Hello world", style: TextStyle(color: Colors.white)),
                color: Colors.red,
              ),
              bottom: 40,
            ),
            Positioned(
              left: 18.0,
              bottom: 40,
              child: Text("I am Jack"),
            ),
            Positioned(
              right: 40,
              top: 400,
              child: Image.asset(
                'assets/images/zccat.png',
                width: 160,
                // height: 100,
              ),
            ),
            Positioned(
              top: 18.0,
              right: 20,
              child: Text("Your friend"),
            ),
            Positioned(
                top: 40,
                left: 40,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  color: Colors.blue[50],
                  child: Align(
                    alignment: Alignment(-1, -1),
                    child: FlutterLogo(
                      size: 60,
                      textColor: Colors.orange,
                    ),
                  ),
                )),
            Positioned(
                top: 250,
                left: 40,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  color: Colors.blue[50],
                  child: Align(
                    alignment: FractionalOffset.center,
                    child: FlutterLogo(
                      size: 60,
                      textColor: Colors.orange,
                    ),
                  ),
                )),
            Positioned(
              top: 250,
              left: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Center(
                  widthFactor: 2,
                  heightFactor: 2,
                  child: Text("xxx"),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: double.infinity, //宽度尽可能大
                  minHeight: 30.0 //最小高度为50像素
                  ),
              child: Container(height: 5.0, color: Colors.orange[100], child: Text("ConstrainedBox")),
            ),
            SizedBox(),
            AspectRatio(
              aspectRatio: 2,
            ),
            LimitedBox(),
            FractionallySizedBox(
              widthFactor: 2,
              heightFactor: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
