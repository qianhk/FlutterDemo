import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../utils/extension.dart';

class DemoDecoratedBox extends DecoratedBox {
  const DemoDecoratedBox({
    Key key,
    Decoration decoration,
    DecorationPosition position = DecorationPosition.background,
    Widget child,
  }) : super(key: key, decoration: decoration, position: position, child: child);

  @override
  RenderDecoratedBox createRenderObject(BuildContext context) {
    return DemoRenderDecoratedBox(
      decoration: decoration,
      position: position,
      configuration: createLocalImageConfiguration(context),
    );
  }
}

class DemoRenderDecoratedBox extends RenderDecoratedBox {
  DemoRenderDecoratedBox({
    Decoration decoration,
    DecorationPosition position = DecorationPosition.background,
    ImageConfiguration configuration = ImageConfiguration.empty,
    RenderBox child,
  }) : super(decoration: decoration, position: position, configuration: configuration, child: child);

  @override
  bool hitTest(BoxHitTestResult result, {Offset position}) {
    bool hitTest = false;
    // var hitTest = super.hitTest(result, position: position);
    Size tmpSize = size ?? Size.zero;
    if (tmpSize.containsExt(position, EdgeInsets.only(top: -40))) {
      if (hitTestChildren(result, position: position) || (tmpSize.contains(position) && hitTestSelf(position))) {
        result.add(BoxHitTestEntry(this, position));
        hitTest = true;
      }
    }
    print('lookKaiHit DecoratedBox hitTest result=$hitTest position=$position result=${result.path.length}');
    return hitTest;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    var hitTestChildren = super.hitTestChildren(result, position: position);
    print('lookKaiHit DecoratedBox hitTestChildren result=$hitTestChildren position=$position result=${result.path.length}');
    return hitTestChildren;
  }

  @override
  bool hitTestSelf(Offset position) {
    bool hitTestSelf = super.hitTestSelf(position);
    print('lookKaiHit DecoratedBox hitTestSelf result=$hitTestSelf position=$position');
    return hitTestSelf;
  }
}
