import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kai_flutter_demo_module/custom/demo_kai_painter.dart';

class ChannelTestPage extends StatefulWidget {
  const ChannelTestPage({Key key}) : super(key: key);

  @override
  _ChannelTestPageState createState() => _ChannelTestPageState();
}

class _ChannelTestPageState extends State<ChannelTestPage> {
  String _methodChannelData = '';
  String _baseMessageChannelData = '';
  String _eventChannelData = '';

  static const batteryChannel = MethodChannel('samples.flutter.dev/battery');
  static const baseMsgChannel = BasicMessageChannel('samples.flutter.dev/basicMessage', StandardMessageCodec());
  static const eventChannel = EventChannel('samples.flutter.dev/EventChannel');

  StreamSubscription _listen;

  @override
  void initState() {
    super.initState();
    _listen = eventChannel.receiveBroadcastStream().listen(_onEventData);
  }

  @override
  void dispose() {
    _listen.cancel();
    super.dispose();
  }

  _onEventData(event) {
    setState(() {
      _eventChannelData = 'eventType=${event?.runtimeType} $event';
    });
  }

  void _onPressedMethodChannel() async {
    try {
      final int result = await batteryChannel.invokeMethod('getBatteryLevel');
      _methodChannelData = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      _methodChannelData = "Failed to get battery level: '${e.message}'.";
    }
    setState(() {});
  }

  void _onPressedBaseMessageChannel() async {
    var result = await baseMsgChannel.send({'name': 'fei', 'age': 18});
    if (result is Map) {
      var name = result['name'];
      var age = result['age'];
      setState(() {
        _baseMessageChannelData = '$name,$age';
      });
    } else {
      _baseMessageChannelData = '$result';
    }
  }

  void _onPressedEventChannel() async {
    // eventChannel.receiveBroadcastStream().listen(_onEventData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChannelTestPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              '$_methodChannelData',
            ),
            ElevatedButton(onPressed: _onPressedMethodChannel, child: Text("Method Channel")),
            SizedBox(height: 20),
            Text(
              '$_baseMessageChannelData',
            ),
            ElevatedButton(onPressed: _onPressedBaseMessageChannel, child: Text("Base Message Channel")),
            SizedBox(height: 20),
            Text(
              '$_eventChannelData',
            ),
            ElevatedButton(onPressed: _onPressedEventChannel, child: Text("Event Channel")),
            SizedBox(height: 20),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.orange[50]),
              child: CustomPaint(
                size: Size(300, 160),
                painter: DemoKaiPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
