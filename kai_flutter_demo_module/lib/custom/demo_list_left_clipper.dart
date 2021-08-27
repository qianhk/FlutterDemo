import 'package:flutter/material.dart';

class DemoListLeftClipper extends CustomClipper<Path> {
  final double strokeWidth;
  final double radius;
  Path path = Path();

  DemoListLeftClipper({this.strokeWidth = 10, this.radius = 10});

  @override
  Path getClip(Size size) {
    bool trueClip = true;

    if (trueClip) {
      return getMeClip(size);
    } else {
      Rect rect = Offset.zero & size;
      path.reset();
      path.addRect(rect);
      // path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
      return path;
    }
  }

  Path getMeClip(Size size) {
    path.reset();
    Rect rect = Offset.zero & size;
    Rect innerRect = rect.deflate(strokeWidth);
    Radius circleRadius = Radius.circular(radius);
    var outerRrect = RRect.fromRectAndRadius(rect, circleRadius);
    var innerRrect = RRect.fromRectAndRadius(innerRect, circleRadius);
    path.addRRect(innerRrect);
    path.addRect(Rect.fromLTRB(rect.left, innerRect.top + radius, innerRect.right, innerRect.bottom - radius));
    if (radius <= strokeWidth) {
      Rect leftTopRect = Rect.fromLTWH(0, 0, strokeWidth, strokeWidth + radius);
      path.addRRect(RRect.fromRectAndCorners(leftTopRect, topLeft: circleRadius));
    } else {
      Rect leftTopRect = Rect.fromLTWH(0, 0, radius, strokeWidth + radius);
      var rRect = RRect.fromRectAndCorners(leftTopRect, topLeft: circleRadius);
      var clipRect = Rect.fromLTWH(strokeWidth, 0, radius, leftTopRect.height);
      var combine = Path.combine(PathOperation.difference, Path()..addRRect(rRect), Path()..addRect(clipRect));
      path.addPath(combine, Offset.zero);
    }

    if (radius <= strokeWidth) {
      Rect leftBottomRect = Rect.fromLTWH(0, size.height - strokeWidth - radius, strokeWidth, strokeWidth + radius);
      path.addRRect(RRect.fromRectAndCorners(leftBottomRect, bottomLeft: circleRadius));
    } else {
      Rect leftBottomRect = Rect.fromLTWH(0, size.height - strokeWidth - radius, radius, strokeWidth + radius);
      var rRect = RRect.fromRectAndCorners(leftBottomRect, bottomLeft: circleRadius);
      var clipRect = Rect.fromLTWH(strokeWidth, leftBottomRect.top, radius, leftBottomRect.height);
      var combine = Path.combine(PathOperation.difference, Path()..addRRect(rRect), Path()..addRect(clipRect));
      path.addPath(combine, Offset.zero);
    }
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    if (oldClipper.runtimeType != DemoListLeftClipper) {
      return true;
    }
    final DemoListLeftClipper typedOldClipper = oldClipper as DemoListLeftClipper;
    return true;
  }
}
