import 'package:flutter/material.dart';

class DemoListLeftClipper extends CustomClipper<Path> {
  final double strokeWidth;
  final double radius;
  final Path path = Path();

  DemoListLeftClipper({this.strokeWidth = 10, this.radius = 10});

  @override
  Path getClip(Size size) {
    bool trueClip = true;

    if (trueClip) {
      return getMeClip(size);
    } else {
      Rect rect = Offset.zero & size;
      path.reset();
      path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
      return path;
    }
  }

  Path getMeClip(Size size) {
    path.reset();
    Rect rect = Offset.zero & size;
    Rect innerRect = rect.deflate(strokeWidth);
    var outerRrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    var innerRrect = RRect.fromRectAndRadius(innerRect, Radius.circular(radius));
    path.addRRect(innerRrect);
    path.addRect(Rect.fromLTRB(rect.left, innerRect.top + radius, innerRect.right, innerRect.bottom - radius));
    Rect leftTopRect = Rect.fromLTWH(0, 0, strokeWidth, strokeWidth + radius);
    path.addRRect(RRect.fromRectAndCorners(leftTopRect, topLeft: Radius.circular(radius)));
    Rect leftBottomRect = Rect.fromLTWH(0, size.height - strokeWidth - radius, strokeWidth, strokeWidth + radius);
    path.addRRect(RRect.fromRectAndCorners(leftBottomRect, bottomLeft: Radius.circular(radius)));
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
