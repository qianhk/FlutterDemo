import 'package:flutter/material.dart';

import 'demo_list_left_clipper.dart';

class DemoListLeftBorder extends ShapeBorder {
  final double strokeWidth;
  final double radius;

  final Paint _paint = Paint();

  @override
  EdgeInsetsGeometry get dimensions => null;

  DemoListLeftBorder({this.strokeWidth = 10, this.radius = 10}) {
    _paint.isAntiAlias = true;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    // var path = Path();
    // path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(40)));
    // return path;
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    var path = Path();
    // // path.fillType = PathFillType.evenOdd;
    // path.addRect(Rect.fromLTRB(40, rect.top, rect.right, rect.bottom));
    // // // path.addOval(rect); //多个形状则默认重叠部分
    // path.addRect(rect);
    path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
    // path = null;
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // var paint = Paint()
    //   ..color = Colors.white
    //   ..strokeWidth = 2.0
    //   ..style = PaintingStyle.stroke
    //   ..strokeJoin = StrokeJoin.round;
    // var w = rect.width;
    // var h = rect.height;
    // var offset = Offset(0.5 * w, -0.45 * h);
    // canvas.drawCircle(offset, 0.2 * h, paint);
    // canvas.drawCircle(
    //     offset,
    //     0.1 * h,
    //     paint
    //       ..style = PaintingStyle.fill
    //       ..color = Colors.green);

    double diameter = radius * 2;

    _paint.color = const Color(0x400000FF);
    _paint.style = PaintingStyle.fill;
    _paint.strokeWidth = strokeWidth;
    Rect innerRect = rect.deflate(strokeWidth);
    var outerRrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    var innerRrect = RRect.fromRectAndRadius(innerRect, Radius.circular(radius));
    // canvas.drawRRect(outerRrect, _paint);
    canvas.drawDRRect(outerRrect, innerRrect, _paint);

    // Path path = Path();
    // final double offset2 = 6;
    // final double baseX = 30;
    // final double borderWidth = 5;
    // Size size = Size(150, 150);
    //
    // double topY = borderWidth;
    // double bottomY = size.height - borderWidth;
    // double rightX = size.width - borderWidth;
    //
    // path.moveTo(baseX - offset2, topY + radius);
    // path.lineTo(baseX - offset2, bottomY - radius);
    // path.lineTo(baseX, bottomY - radius);
    // // path.quadraticBezierTo(0, size.height, radius, size.height);
    // path.arcTo(Rect.fromLTWH(baseX, bottomY - radius, radius, radius), 180, -90, false);
    // path.lineTo(rightX - radius, bottomY);
    // // path.quadraticBezierTo(rightX, bottomY, rightX, bottomY - radius);
    // path.arcTo(Rect.fromLTWH(rightX - diameter, bottomY - diameter, diameter, diameter), 90, -355, false);
    // path.lineTo(rightX, topY + radius);
    // path.quadraticBezierTo(rightX, topY, rightX - radius, topY);
    // path.lineTo(baseX + radius, topY);
    // path.quadraticBezierTo(baseX, topY, baseX, topY + radius);
    // path.close();

    var clipper = DemoListLeftClipper();

    // path.addRRect(innerRrect);
    // path.addRect(Rect.fromLTRB(rect.left, innerRect.top + radius, innerRect.right, innerRect.bottom - radius));
    _paint.style = PaintingStyle.fill;
    _paint.color = Colors.blue;
    _paint.strokeWidth = 1;
    // canvas.drawPath(clipper.getMeClip(rect.size), _paint);

    // canvas.drawRect(Rect.fromLTWH(0, rect.bottom + 6, rect.width, 10), _paint..color = Colors.green);
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
