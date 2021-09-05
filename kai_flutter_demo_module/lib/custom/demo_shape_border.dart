import 'package:flutter/material.dart';

class DemoShapeBorder extends ShapeBorder {
  final Offset offset;
  final double size;

  @override
  EdgeInsetsGeometry get dimensions => null;

  DemoShapeBorder({this.offset = const Offset(0.1, 0.1), this.size = 20});

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    var path = Path();
    path.addRRect(RRect.fromRectAndRadius(rect.deflate(20), Radius.circular(40)));
    return path;
    // return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    var path = Path();
    // path.addRect(rect);
    path.fillType = PathFillType.evenOdd;
    // path.addRect(Rect.fromLTRB(20, rect.top, rect.right, rect.bottom));
    // path.addOval(rect); //多个形状则默认重叠部分
    path.addRRect(RRect.fromRectAndRadius(rect.deflate(0), Radius.circular(16)));

    var w = rect.width;
    var h = rect.height;
    var middleXY = Offset(offset.dx * w, offset.dy * h);
    _getHold(path, 1, size, middleXY);
    // return path;
    return null;
  }

  _getHold(Path path, int count, double size, Offset middle) {
    var left = middle.dx;
    var top = middle.dy;
    path.addOval(Rect.fromLTRB(left, top, left + size, top + size));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    var w = rect.width;
    var h = rect.height;
    canvas.drawCircle(Offset(0.3 * h, 0.23 * h), 0.12 * h, paint);
    canvas.drawCircle(
        Offset(0.3 * h, 0.23 * h),
        0.06 * h,
        paint
          ..style = PaintingStyle.fill
          ..color = Colors.black);
    canvas.drawRect(Rect.fromLTWH(0, rect.bottom + 6, rect.width, 10), paint..color = Colors.green);
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
