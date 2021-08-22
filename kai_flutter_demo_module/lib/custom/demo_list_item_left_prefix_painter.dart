import 'package:flutter/material.dart';

class DemoListItemLeftPrefixPainter extends CustomPainter {
  Paint _paint;
  Path path = Path();
  final bool doIt;

  DemoListItemLeftPrefixPainter({this.doIt = false}) {
    _paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 4;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (this.doIt) {
      path.moveTo(0, -10);
      path.reset();
      double prefixWidth = 5;
      var points = [Offset(0, -10), Offset(0, size.height + 10), Offset(prefixWidth, size.height), Offset(prefixWidth, 0)];
      path.addPolygon(points, true);
      _paint.style = PaintingStyle.fill;
      canvas.drawPath(path, _paint);

      _paint.color = Colors.blue;
      canvas.drawRect(Rect.fromLTRB(prefixWidth, 0, size.width, size.height), _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
