import 'package:flutter/material.dart';

class DemoKaiPainter extends CustomPainter {
  Paint _paint;

  DemoKaiPainter() {
    _paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 4;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // print('lookKai painter: $size');
    canvas.save();
    var wholeRect = Offset.zero & size;
    ;
    // canvas.clipRect(wholeRect);

    // canvas.drawColor(Colors.green[50], BlendMode.srcOver);

    _paint.color = Colors.amber;
    canvas.drawCircle(size.center(Offset.zero), size.width * 0.5 - _paint.strokeWidth / 2, _paint);

    _paint.color = Colors.blue;
    canvas.drawOval(wholeRect.deflate(6 + _paint.strokeWidth / 2), _paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
