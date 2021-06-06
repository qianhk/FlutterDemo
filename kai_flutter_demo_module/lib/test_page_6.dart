import 'package:flutter/material.dart';
import 'dart:math';

class TestPage6 extends StatefulWidget {
  @override
  _ThemeTestRouteState createState() => new _ThemeTestRouteState();
}

class _ThemeTestRouteState extends State<TestPage6> {
  Color _themeColor = Colors.teal; //当前路由主题色
  int _beginJs = 0;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
          primarySwatch: _themeColor, //用于导航栏、FloatingActionButton的背景色等
          iconTheme: IconThemeData(color: _themeColor) //用于Icon颜色
          ),
      child: Scaffold(
        appBar: AppBar(title: Text("主题测试")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //第一行Icon使用主题中的iconTheme
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Icon(Icons.favorite), Icon(Icons.airport_shuttle), Text("  颜色跟随主题")]),
            //为第二行Icon自定义颜色（固定为黑色)
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(color: Colors.black),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Icon(Icons.favorite), Icon(Icons.airport_shuttle), Text("  颜色固定黑色")]),
            ),
            SizedBox(
              height: 30,
            ),
            FutureBuilder<String>(
              future: mockNetworkData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // 请求已结束
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // 请求失败，显示错误
                    return Text(
                      "Error: ${snapshot.error}",
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    );
                  } else {
                    // 请求成功，显示数据
                    return Text("Contents: ${snapshot.data}");
                  }
                } else {
                  // 请求未结束，显示loading
                  return CircularProgressIndicator();
                }
              },
            ),
            StreamBuilder<int>(
              stream: counter(_beginJs), //
              //initialData: ,// a Stream<int> or null
              initialData: _beginJs,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    print('没有Stream');
                    return Text('没有Stream');
                  case ConnectionState.waiting:
                    print('等待数据... init=${snapshot.data}');
                    return Text('等待数据... init=${snapshot.data}');
                  case ConnectionState.active:
                    _beginJs = snapshot.data;
                    return Text('active: ${snapshot.data}');
                  case ConnectionState.done:
                    print('Stream已关闭');
                    return Text('Stream已关闭');
                }
                return null; // unreachable
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => //切换主题
                setState(() => _themeColor = _themeColor == Colors.teal ? Colors.orange : Colors.teal),
            child: Icon(Icons.palette)),
      ),
    );
  }
}

Future<String> mockNetworkData() async {
  if (Random().nextBool()) {
    return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  } else {
    return Future.delayed(Duration(seconds: 2), () {
      // throw UnimplementedError("kai unimplement get network.");
      throw UnimplementedError("kai un implement get data from network, only for test.");
    });
  }
}

Stream<int> counter(int js) {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i + js;
  });
}
