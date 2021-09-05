import 'dart:ui';

import 'package:flutter/material.dart';

extension ExtendedSize on Size {
  bool containsExt(Offset offset, EdgeInsets edgeInsets) {
    return offset.dx >= edgeInsets.left &&
        offset.dx < width + edgeInsets.right &&
        offset.dy >= edgeInsets.top &&
        offset.dy < height + edgeInsets.bottom;
  }
}
