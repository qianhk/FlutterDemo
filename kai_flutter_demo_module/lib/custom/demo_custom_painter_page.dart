import 'package:flutter/material.dart';

import 'demo_kai_painter2.dart';
import 'demo_shape_border.dart';
import 'demo_shape_border2.dart';

class DemoCustomPainterPage extends StatefulWidget {
  const DemoCustomPainterPage({Key key}) : super(key: key);

  @override
  _DemoCustomPainterPageState createState() => _DemoCustomPainterPageState();
}

class _DemoCustomPainterPageState extends State<DemoCustomPainterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Painter'),
      ),
      backgroundColor: Colors.blue[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                // color: Colors.green,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: Colors.green,
                  width: 20,
                  style: BorderStyle.solid,
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.orange[100],
                //     offset: Offset(0.0, 0.0),
                //     spreadRadius: 10,
                //     // blurRadius: 10,
                //   ),
                // ],
              ),
              child: Opacity(
                opacity: 0.49,
                child: Image.asset(
                  'assets/images/hsfengjing.jpg',
                  width: 300,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 20),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                // border: Border.all(
                //   color: Colors.orange,
                //   width: 10,
                //   style: BorderStyle.solid,
                // ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.orange[100],
                //     offset: Offset(0.0, 0.0),
                //     spreadRadius: 10,
                //     // blurRadius: 10,
                //   ),
                // ],
              ),
              child: CustomPaint(
                size: Size(300, 140),
                painter: DemoKaiPainter2(strokeWidth: 10, radius: 40),
              ),
            ),
            SizedBox(height: 20),
            Material(
              color: Colors.orangeAccent,
              elevation: 0,
              shape: DemoShapeBorder(offset: Offset(0.9, 0.1)),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 80,
                width: 300,
                child: Text(
                  "KaiKai Sharp Border",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 40),
            ClipPath(
              clipper: ShapeBorderClipper(shape: DemoShapeBorder2()),
              child: Material(
                elevation: 0,
                shape: DemoShapeBorder2(),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.green[100],
                  padding: EdgeInsets.all(10),
                  height: 140,
                  width: 300,
                  child: Text(
                    "KaiKai2 Sharp Border",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
