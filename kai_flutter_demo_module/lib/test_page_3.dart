import 'package:flutter/material.dart';

class TestPage3 extends StatefulWidget {
  TestPage3({Key key, this.title = "TestPage3"}) : super(key: key);
  final String title;

  @override
  _TestPage3State createState() => _TestPage3State();
}

class _TestPage3State extends State<TestPage3> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //导航栏
        title: Text("Kai Test Page 03"),
        actions: <Widget>[
          //导航栏右侧菜单
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),
      drawer: Container(
        color: Colors.pink,
        constraints: BoxConstraints.expand(width: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Drawer"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(Icons.add),
          onPressed: _onAdd),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}
}
