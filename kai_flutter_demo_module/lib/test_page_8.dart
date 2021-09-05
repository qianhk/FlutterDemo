import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'hit/demo_decorated_box.dart';
import 'hit/demo_size_box.dart';
import 'hit/demo_stack.dart';

class TestPage8 extends StatefulWidget {
  TestPage8({Key key, this.title = "TestPage8"}) : super(key: key);
  final String title;

  @override
  _TestPage8State createState() => _TestPage8State();
}

class _TestPage8State extends State<TestPage8> with SingleTickerProviderStateMixin {
  String _operation = "No Gesture detected!";
  double _top = 60.0; //距顶部的偏移
  double _left = 60.0; //距左边的偏移
  double _beginX, _beginY;
  bool _appendInit;
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false; //变色开关
  AnimationController _controller;
  CurvedAnimation _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..value = 0.5;
    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () => updateText("Tap"),
        onDoubleTap: () {
          updateText("DoubleTap");
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        onLongPress: () => updateText("LongPress"),
        child: Center(
          child:
              // Listener(
              //     child: ConstrainedBox(
              //       constraints: BoxConstraints.tight(Size(300.0, 150.0)),
              //       child: Center(child: Text("Box A")),
              //     ),
              //     behavior: HitTestBehavior.translucent,
              //     onPointerDown: (event) => print("down A")),
              DemoSizedBox(
            width: 350,
            height: 600,
            child: DemoDecoratedBox(
              decoration: BoxDecoration(
                color: Colors.green[100],
              ),
              child: DemoStack(
                // fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: <Widget>[
                  Listener(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(Size(300.0, 200.0)),
                      child: DecoratedBox(decoration: BoxDecoration(color: Colors.lightGreenAccent[100])),
                    ),
                    onPointerDown: (event) => print("down0"),
                  ),
                  Listener(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                      // child: Center(child: Text("左上角200*100范围内非文本区域点击")),
                      child: Center(child: Text(_operation)),
                    ),
                    onPointerDown: (event) => print("down1"),
                    //可以试出来deferToChild只管非透明区域，透明区域传下去  translucent自己也管透明区域也传下去 opaque当自己不透明不传下去
                    behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
                    // behavior: HitTestBehavior.opaque,
                  ),
                  Positioned(
                    top: _top,
                    left: _left,
                    child: GestureDetector(
                      child: RotationTransition(turns: _curve, child: CircleAvatar(child: Text("Kai"))),
                      //手指按下时会触发此回调
                      // onPanDown: (DragDownDetails e) {
                      //   //打印手指按下的位置(相对于屏幕)
                      //   print("用户手指按下：${e.globalPosition}");
                      //   _appendInit = true;
                      //   _beginX = e.globalPosition.dx;
                      //   _beginY = e.globalPosition.dy;
                      // },
                      //手指滑动时会触发此回调
                      // onPanUpdate: (DragUpdateDetails e) {
                      //   //用户手指滑动时，更新偏移，重新构建
                      //   setState(() {
                      //     if (_appendInit) {
                      //       _left += (e.globalPosition.dx - _beginX);
                      //       _top += (e.globalPosition.dy - _beginY);
                      //       _appendInit = false;
                      //     } else {
                      //       _left += e.delta.dx;
                      //       _top += e.delta.dy;
                      //     }
                      //     // print("用户滑动：${e.globalPosition} _left=$_left _top=$_top");
                      //   });
                      // },
                      // onPanEnd: (DragEndDetails e) {
                      //   //打印滑动结束时在x、y轴上的速度
                      //   print(e.velocity);
                      // },
                      // onPanCancel: () {
                      //   print("onPanCancel");
                      // },
                      onVerticalDragUpdate: (DragUpdateDetails details) {
                        setState(() {
                          _top += details.delta.dy;
                        });
                      },
                      onHorizontalDragUpdate: (DragUpdateDetails details) {
                        setState(() {
                          _left += details.delta.dx;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    top: 260,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "你好世界"),
                          TextSpan(
                            text: "点我变色",
                            style: TextStyle(fontSize: 30.0, color: _toggle ? Colors.blue : Colors.red),
                            recognizer: _tapGestureRecognizer
                              ..onTap = () {
                                setState(() {
                                  _toggle = !_toggle;
                                });
                              },
                          ),
                          TextSpan(text: "你好世界2"),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      left: 10,
                      top: -40,
                      child: ElevatedButton(
                        onPressed: () {
                          Fluttertoast.showToast(msg: 'orange button');
                        },
                        child: Icon(Icons.account_box, size: 80, color: Colors.orange),
                      )),
                  Transform.translate(
                    transformHitTests: true,
                    offset: Offset(140, -40),
                    child: ElevatedButton(
                      onPressed: () {
                        Fluttertoast.showToast(msg: 'purple button');
                      },
                      child: Icon(Icons.access_alarm, size: 80, color: Colors.purple),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.85, -1.15),
                    child: ElevatedButton(
                      onPressed: () {
                        Fluttertoast.showToast(msg: 'Pink button');
                      },
                      child: Icon(Icons.airplanemode_active, size: 80, color: Colors.pink),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
