import 'package:flutter/material.dart';

class TestPage3 extends StatefulWidget {
  TestPage3({Key key, this.title = "TestPage3"}) : super(key: key);
  final String title;

  @override
  _TestPage3State createState() => _TestPage3State();
}

class KaiTabInfo {
  String title;
  Color bkgColor;

  KaiTabInfo(this.title, this.bkgColor);
}

class _TestPage3State extends State<TestPage3> {
  int _selectedIndex = 1;

  // TabController _tabController;
  List<KaiTabInfo> tabs = <KaiTabInfo>[
    KaiTabInfo("新闻", Colors.orange),
    KaiTabInfo("历史", Colors.green),
    KaiTabInfo("图片", Colors.pink),
  ];

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          //导航栏
          title: Text("Kai Test Page 03"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.share), onPressed: () {}),
          ],
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.dashboard, color: Colors.white), //自定义图标
              onPressed: () {
                // 打开抽屉菜单
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          bottom: TabBar(
            tabs: tabs.map((item) => Tab(text: item.title)).toList(),
            // controller: _tabController,
          ),
        ),
        drawer: Container(
          color: Colors.pink,
          constraints: BoxConstraints.expand(width: 240),
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
        body: TabBarView(
          children: tabs.map((KaiTabInfo info) {
            return Container(
              alignment: Alignment.center,
              color: info.bkgColor,
              child: Text(info.title, textScaleFactor: 3),
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(Icons.add),
          onPressed: _onAdd,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}
}
