import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kai_flutter_demo_module/utils/kai_utils.dart';

class TestPage7 extends StatefulWidget {
  TestPage7({Key key, this.title = "对话框"}) : super(key: key);
  final String title;

  @override
  _TestPage7State createState() => _TestPage7State();
}

class _TestPage7State extends State<TestPage7> {
  bool withTree = false; // 复选框选中状态

  void onPressedDialog1() async {
    bool delete = await showDeleteConfirmDialog1();
    if (delete == null) {
      print("取消删除");
      Fluttertoast.showToast(msg: "取消删除");
    } else {
      print("已确认删除");
      Fluttertoast.showToast(msg: "已确认删除");
      //... 删除文件
    }
  }

  void onPressedDialog2() async {
    // var result = changeLanguage(); // result is Future<int>
    var result = await changeLanguage(); // result is int or null
    print('onPressedDialog2=${result}');
    if (result != null) {
      print("选择了：${result == 1 ? "中文简体" : "美国英语"}");
      Fluttertoast.showToast(msg: "选择了：${result == 1 ? "中文简体" : "美国英语"}");
    }
  }

  void onPressedDialog3() {}

  void onPressedDialog4() {}

  Future<bool> showDeleteConfirmDialog1() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示1"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            OutlinedButton(
              child: Text("删除"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<int> changeLanguage() async {
    // var instance = BoostNavigator.instance;
    // var appState2 = instance.appState;
    // var topContainer2 = appState2.topContainer;
    // var navigator2 = topContainer2.navigator;
    // var context2 = navigator2.context;
    // // FlutterBoost.containerManager?.remove("2000000");
    // // BoostChannel.instance.
    // var currentContext = overlayKey.currentContext;
    // var currentState = overlayKey.currentState;
    // var currentWidget = overlayKey.currentWidget;
    // var boostContainer = BoostContainer.of(context);
    var selfContext = context;
    return showDialog<int>(
        context: context,
        useRootNavigator: false,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('请选择语言'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  // 返回1
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('中文简体'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('美国英语'),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                // onPressed: () => BoostNavigator.instance.push(
                //   "/dialogPage",
                //   // withContainer: true,
                //   // opaque: false, //如果开启新容器，需要指定opaque为false
                // ),
                onPressed: () => navigatorPush(context, '/dialogPage'),
                child: Text("dialogPage"),
              ),
              ElevatedButton(
                onPressed: onPressedDialog1,
                child: Text("showDeleteConfirmDialog"),
                style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
              ),
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.green[200]),
                child: ElevatedButton(
                  onPressed: onPressedDialog2,
                  child: Text("请选择语言"),
                  style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size.zero), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: showDeleteConfirmDialogWithCheck1,
                child: Text("复选框可点击1"),
                style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              ),
              ElevatedButton(onPressed: showDeleteConfirmDialogWithCheck2, child: Text("复选框可点击2")),
              ElevatedButton(onPressed: showDeleteConfirmDialogWithCheck3, child: Text("复选框可点击3")),
              ElevatedButton(onPressed: onPressedDialog5, child: Text("显示列表对话框")),
              ElevatedButton(onPressed: onPressedDialog6, child: Text("自定义对话框")),
              ElevatedButton(onPressed: _showModalBottomSheet, child: Text("显示底部菜单列表")),
              Builder(builder: (context) {
                return ElevatedButton(onPressed: () => _showBottomSheet(context), child: Text("_showBottomSheet"));
              }),
              ElevatedButton(onPressed: showLoadingDialog, child: Text("showLoadingDialog")),
              ElevatedButton(onPressed: _showDatePicker1, child: Text("_showDatePicker1")),
              ElevatedButton(onPressed: _showDatePicker2, child: Text("_showDatePicker2")),
            ],
          ),
        ),
      ),
    );
  }

  void onPressedDialog5() {}

  void onPressedDialog6() {}

  Future<int> _showModalBottomSheet() {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
              onTap: () => Navigator.of(context).pop(index),
            );
          },
        );
      },
    );
  }

  PersistentBottomSheetController<int> _showBottomSheet(BuildContext context) {
    return showBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
              onTap: () {
                // do something
                print("$index");
                Navigator.of(context).pop();
              },
            );
          },
        );
      },
    );
  }

  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, //点击遮罩是否关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("正在加载，请稍后..."),
              )
            ],
          ),
        );
      },
    );
  }

  Future<DateTime> _showDatePicker1() {
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(
        //未来30天可选
        Duration(days: 30),
      ),
    );
  }

  Future<DateTime> _showDatePicker2() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(
              Duration(days: 30),
            ),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              print(value);
            },
          ),
        );
      },
    );
  }

  Future<bool> showDeleteConfirmDialogWithCheck1() {
    withTree = false; // 默认复选框不选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示2"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  DialogCheckbox(
                    value: withTree,
                    onChanged: (bool value) {
                      //复选框选中状态发生变化时重新构建UI
                      setState(() {
                        //更新复选框状态
                        withTree = !withTree;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("删除"),
              onPressed: () {
                //执行删除操作
                Navigator.of(context).pop(withTree);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> showDeleteConfirmDialogWithCheck2() {
    withTree = false; // 默认复选框不选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text("您确定要删除当前文件吗?"),
            Row(
              children: <Widget>[
                Text("同时删除子目录？"),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter _setState) {
                    return Checkbox(
                        value: withTree, //默认不选中
                        onChanged: (bool value) {
                          //_setState方法实际就是该StatefulWidget的setState方法，
                          //调用后builder方法会重新被调用
                          _setState(() {
                            //更新选中状态
                            withTree = !withTree;
                          });
                        });
                  },
                ),
              ],
            ),
          ]),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("删除"),
              onPressed: () {
                //执行删除操作
                Navigator.of(context).pop(withTree);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> showDeleteConfirmDialogWithCheck3() {
    bool _withTree = false;
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  Checkbox(
                    // 依然使用Checkbox组件
                    value: _withTree,
                    onChanged: (bool value) {
                      // 此时context为对话框UI的根Element，我们
                      // 直接将对话框UI对应的Element标记为dirty
                      (context as Element).markNeedsBuild();
                      _withTree = !_withTree;
                    },
                  ),
                  // 通过Builder来获得构建Checkbox的`context`，
                  // 这是一种常用的缩小`context`范围的方式
                  Builder(
                    builder: (BuildContext context) {
                      return Checkbox(
                        value: _withTree,
                        onChanged: (bool value) {
                          (context as Element).markNeedsBuild();
                          _withTree = !_withTree;
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("删除"),
              onPressed: () {
                // 执行删除操作
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }
}

// 单独封装一个内部管理选中状态的复选框组件
class DialogCheckbox extends StatefulWidget {
  DialogCheckbox({
    Key key,
    this.value,
    @required this.onChanged,
  });

  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  _DialogCheckboxState createState() => _DialogCheckboxState();
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  bool value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) {
        //将选中状态通过事件的形式抛出
        widget.onChanged(v);
        setState(() {
          //更新自身选中状态
          value = v;
        });
      },
    );
  }
}
