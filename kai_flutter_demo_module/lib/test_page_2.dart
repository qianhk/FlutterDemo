import 'package:flutter/material.dart';
import 'dart:math' as math;

class TestPage2 extends StatefulWidget {
  TestPage2({Key? key, this.title = "Test 02"}) : super(key: key);
  final String title;

  @override
  _TestPage2State createState() => _TestPage2State();
}

class _TestPage2State extends State<TestPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 40),
          margin: EdgeInsets.all(0),
          constraints: BoxConstraints.expand(),
          color: Colors.green[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Text2:',
              ),
              DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.red, Colors.orange[700]!]),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              Container(
                color: Colors.blue[100],
                child: Transform(
                  alignment: Alignment.bottomRight, //相对于坐标系原点的对齐方式
                  transform: Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
                  child: Container(
                    margin: EdgeInsets.only(top: 80),
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.deepOrange,
                    child: const Text('Apartment'),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.translate(
                  offset: Offset(10.0, 10),
                  child: Text("Hello world"),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.green),
                position: DecorationPosition.background,
                child: Transform.rotate(
                  angle: math.pi / 4,
                  child: Text(
                    "Hello world",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                    child: Transform.scale(scale: 1.5, child: Text("Hello world")),
                  ),
                  Text(
                    "你好",
                    style: TextStyle(color: Colors.green, fontSize: 18.0),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                    //将Transform.rotate换成RotatedBox
                    child: RotatedBox(
                      quarterTurns: 1, //旋转90度(1/4圈)
                      child: Text("Hello world"),
                    ),
                  ),
                  Text(
                    "你好",
                    style: TextStyle(color: Colors.green, fontSize: 18.0),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0, left: 0.0),
                constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
                decoration: BoxDecoration(
                    gradient: RadialGradient(colors: [Colors.red, Colors.orange], center: Alignment.topLeft, radius: .98),
                    boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(2.0, 2.0), blurRadius: 4.0)]),
                transform: Matrix4.rotationZ(.0),
                alignment: Alignment.center,
                child: Text(
                  "Kai",
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
              )
            ],
          ),
        ));
  }
}
