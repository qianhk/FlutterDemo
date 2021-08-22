import 'dart:math' as math;
import 'package:flutter/material.dart';

class DemoKaiPainter2 extends CustomPainter {
  Paint _paint;
  final double strokeWidth;
  final double radius;

  DemoKaiPainter2({this.strokeWidth, this.radius}) {
    _paint = Paint()
          // ..color = Colors.amber
          // ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt
          ..strokeJoin = StrokeJoin.round
          ..isAntiAlias = true
        // ..strokeWidth = 20;
        ;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // print('lookKai painter: $size');
    canvas.save();
    var wholeRect = Offset.zero & size;
    ;
    // canvas.clipRect(wholeRect);

    // canvas.drawColor(Colors.green[50], BlendMode.srcOver);

    // _paint.color = Colors.amber;
    // canvas.drawCircle(size.center(Offset.zero), size.width * 0.5 - _paint.strokeWidth / 2, _paint);

    _paint.color = Colors.blue;
    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = strokeWidth;
    double diameter = radius * 2;
    Rect innerRect = wholeRect.deflate(strokeWidth / 2);
    // canvas.drawOval(innerRect, _paint);

    _paint.color = const Color(0x8000FF00);
    canvas.drawRRect(RRect.fromRectAndRadius(innerRect, Radius.circular(radius)), _paint);

    final RRect outer = RRect.fromRectAndRadius(wholeRect, Radius.circular(radius));
    final RRect inner = outer.deflate(strokeWidth);
    _paint.color = const Color(0x600000FF);
    _paint.style = PaintingStyle.fill;
    // canvas.drawDRRect(outer, inner, _paint);

    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = strokeWidth;
    canvas.drawCircle(Offset(radius + strokeWidth / 2, radius + strokeWidth / 2), radius, _paint);
    _paint.color = Colors.pink[100];
    Rect tmpRect = Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, diameter, diameter);
    canvas.drawArc(tmpRect, -math.pi / 2, -math.pi / 2, false, _paint);
    _paint.strokeWidth = 1;
    canvas.drawLine(Offset(tmpRect.center.dx, 0), Offset(tmpRect.center.dx, tmpRect.bottom), _paint);
    canvas.drawLine(Offset(0, tmpRect.center.dy), Offset(tmpRect.right, tmpRect.center.dy), _paint);

    tmpRect = Rect.fromLTWH(innerRect.left, innerRect.bottom - diameter, diameter, diameter);
    canvas.drawArc(tmpRect, math.pi, -math.pi / 2, true, _paint);

    tmpRect = Rect.fromLTWH(innerRect.right - diameter, innerRect.bottom - diameter, diameter, diameter);
    // canvas.drawArc(tmpRect, math.pi / 2, -math.pi / 2, false, _paint);
    Path path = Path();
    path.moveTo(tmpRect.left + radius, tmpRect.bottom);
    path.quadraticBezierTo(tmpRect.right, tmpRect.bottom, tmpRect.right, tmpRect.bottom - radius);
    canvas.drawPath(path, _paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
