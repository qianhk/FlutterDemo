import 'package:flutter/material.dart';

class TestPage4 extends StatefulWidget {
  TestPage4({Key key, this.title = "TestPage4"}) : super(key: key);
  final String title;

  @override
  _TestPage4State createState() => _TestPage4State();
}

class _TestPage4State extends State<TestPage4> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Text:',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _onAdd,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(Icons.hot_tub),
                onPressed: () => _onItemTapped(1),
              ),
              SizedBox(), //中间位置空出
              IconButton(
                icon: Icon(Icons.business),
                onPressed: () => _onItemTapped(2),
              ),
              IconButton(
                icon: Icon(Icons.bubble_chart),
                onPressed: () => _onItemTapped(3),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
          ),
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}
}
