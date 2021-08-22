import 'package:flutter/material.dart';

import 'demo_kai_painter2.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
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
                opacity: 0.99,
                child: Image.asset(
                  'assets/images/hsfengjing.jpg',
                  width: 300,
                  height: 140,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 40),
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
          ],
        ),
      ),
    );
  }
}
