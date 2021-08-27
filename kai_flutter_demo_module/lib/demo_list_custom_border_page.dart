import 'package:flutter/material.dart';
import 'package:kai_flutter_demo_module/custom/demo_list_item_left_prefix_painter.dart';
import 'package:kai_flutter_demo_module/custom/demo_list_left_boder.dart';

import 'custom/demo_list_left_clipper.dart';
import 'custom/kai_overscroll_behavior.dart';

class DemoListCustomBorderPage extends StatefulWidget {
  const DemoListCustomBorderPage({Key key}) : super(key: key);

  @override
  _DemoListCustomBorderPageState createState() => _DemoListCustomBorderPageState();
}

class _DemoListCustomBorderPageState extends State<DemoListCustomBorderPage> {
  var _dataList = <String>[];

  _DemoListCustomBorderPageState() {
    for (int idx = 0; idx < 30; ++idx) {
      _dataList.add('string_$idx');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Divider divider = Divider(height: 1, thickness: 1, indent: 20, endIndent: 0, color: Colors.green);
    return Scaffold(
      appBar: AppBar(
        title: Text('DemoListCustomBorder'),
      ),
      backgroundColor: Colors.blue[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
        child: Material(
          color: Colors.red,
          shape: DemoListLeftBorder(strokeWidth: 20, radius: 40),
          child: ClipPath(
            clipper: DemoListLeftClipper(strokeWidth: 20, radius: 40),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                // borderRadius: BorderRadius.circular(40),
              ),
              child: ScrollConfiguration(
                behavior: KaiOverScrollBehavior(),
                child: ListView.separated(
                  itemCount: _dataList?.length ?? 0,
                  // physics: ClampingScrollPhysics(),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var itemData = _dataList[index];
                    return DecoratedBox(
                      decoration: BoxDecoration(color: Colors.green[100]),
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            CustomPaint(
                              size: Size(10, 60),
                              painter: DemoListItemLeftPrefixPainter(doIt: index % 5 == 3),
                            ),
                            SizedBox(width: 10),
                            Text(itemData),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return divider;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
