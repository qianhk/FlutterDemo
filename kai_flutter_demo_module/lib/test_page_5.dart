import 'package:flutter/material.dart';

class TestPage5 extends StatefulWidget {
  TestPage5({Key key, this.title = "InheritedWidget"}) : super(key: key);
  final String title;

  @override
  _TestPage5State createState() => _TestPage5State();
}

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  final int data; //需要在子树中共享的数据，保存点击次数

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget of(BuildContext context) {
    // return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
    return context.getElementForInheritedWidgetOfExactType<ShareDataWidget>().widget;
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(ShareDataWidget old) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return old.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => new __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    print("__TestWidgetState build");
    //使用InheritedWidget中的共享数据
    return Text(ShareDataWidget.of(context).data.toString());
    // return Text('No Use InheritedWidget');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Kai Dependencies change");
  }
}

class _TestPage5State extends State<TestPage5> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    print("_TestPage5State build");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ShareDataWidget(
          data: _count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 10),
                child: _TestWidget(), //子widget中依赖ShareDataWidget
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.add_box_outlined),
                label: Text("Increment"),
                //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
                onPressed: () => setState(() {
                  ++_count;
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
