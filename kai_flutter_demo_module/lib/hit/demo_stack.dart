import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../utils/extension.dart';

class DemoStack extends Stack {
  DemoStack({
    Key key,
    alignment = AlignmentDirectional.topStart,
    textDirection,
    fit = StackFit.loose,
    clipBehavior = Clip.hardEdge,
    List<Widget> children = const <Widget>[],
  }) : super(key: key, alignment: alignment, textDirection: textDirection, fit: fit, clipBehavior: clipBehavior, children: children);

  @override
  RenderStack createRenderObject(BuildContext context) {
    return DemoRenderStack(
      alignment: alignment,
      textDirection: textDirection ?? Directionality.maybeOf(context),
      fit: fit,
      clipBehavior: clipBehavior,
    );
  }
}

class DemoRenderStack extends RenderStack {
  DemoRenderStack({
    List<RenderBox> children,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection textDirection,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
  }) : super(children: children, alignment: alignment, textDirection: textDirection, fit: fit, clipBehavior: clipBehavior);

  @override
  bool hitTest(BoxHitTestResult result, {Offset position}) {
    bool hitTest = false;
    // var hitTest = super.hitTest(result, position: position);
    Size tmpSize = size ?? Size.zero;
    if (tmpSize.containsExt(position, EdgeInsets.only(top: -40))) {
      if (hitTestChildren(result, position: position) || hitTestSelf(position)) {
        result.add(BoxHitTestEntry(this, position));
        hitTest = true;
      }
    }
    print('lookKaiHit Stack hitTest result=$hitTest position=$position result=${result.path.length}');
    return hitTest;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    var hitTestChildren = super.hitTestChildren(result, position: position);
    print('lookKaiHit Stack hitTestChildren result=$hitTestChildren position=$position result=${result.path.length}');
    return hitTestChildren;
  }

  @override
  bool hitTestSelf(Offset position) {
    var hitTestSelf = super.hitTestSelf(position);
    print('lookKaiHit Stack hitTestSelf result=$hitTestSelf position=$position');
    return hitTestSelf;
  }
}
