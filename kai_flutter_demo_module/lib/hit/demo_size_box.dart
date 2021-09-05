import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import '../utils/extension.dart';

class DemoSizedBox extends SizedBox {
  const DemoSizedBox({Key key, double width, double height, Widget child}) : super(key: key, width: width, height: height, child: child);

  @override
  RenderConstrainedBox createRenderObject(BuildContext context) {
    return DemoRenderConstrainedBox(
      additionalConstraints: BoxConstraints.tightFor(width: width, height: height),
    );
  }
}

class DemoRenderConstrainedBox extends RenderConstrainedBox {
  DemoRenderConstrainedBox({
    RenderBox child,
    BoxConstraints additionalConstraints,
  }) : super(child: child, additionalConstraints: additionalConstraints);

  @override
  bool hitTest(BoxHitTestResult result, {Offset position}) {
    bool hitTest = false;
    // var hitTest = super.hitTest(result, position: position);
    // Size tmpSize = size ?? Size.zero;
    Size tmpSize = size ?? Size.zero;
    if (tmpSize.containsExt(position, EdgeInsets.only(top: -40))) {
      if (hitTestChildren(result, position: position) || hitTestSelf(position)) {
        result.add(BoxHitTestEntry(this, position));
        hitTest = true;
      }
    }
    print('lookKaiHit SizedBox hitTest result=$hitTest position=$position result=${result.path.length}');
    return hitTest;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    var hitTestChildren = super.hitTestChildren(result, position: position);
    print('lookKaiHit SizedBox hitTestChildren result=$hitTestChildren position=$position result=${result.path.length}');
    return hitTestChildren;
  }

  @override
  bool hitTestSelf(Offset position) {
    var hitTestSelf = super.hitTestSelf(position);
    print('lookKaiHit SizedBox hitTestSelf result=$hitTestSelf position=$position');
    return hitTestSelf;
  }
}
