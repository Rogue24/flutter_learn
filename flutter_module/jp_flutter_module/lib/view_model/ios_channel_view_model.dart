import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jp_flutter_module/shared/JPLog.dart';

class JPChannelViewModel extends ChangeNotifier {

  String _message = "";

  set message(String value) {
    _message = value;
    notifyListeners(); // 通知所有监听者
  }
  String get message => _message;

  // Flutter官方提供的Channel，可以 接收消息（setMethodCallHandler）和 发送消息（invokeMethod）
  final MethodChannel _iOSFlutterChannel = MethodChannel("zhoujianping.com/iOSFlutter");

  JPChannelViewModel() {
    JPrint("初始化 JPChannelViewModel ！！！");

    // 接收消息（消息名要跟原生端保持一致）
    _iOSFlutterChannel.setMethodCallHandler((MethodCall call) async {

      if (call.method == "event_iOSFlutter") {
        message = call.arguments["message"];
      }

      // 发送消息（消息名要跟原生端保持一致）
      String result = await _iOSFlutterChannel.invokeMethod("getSomeText");
      JPrint("通过invokeMethod发送消息给原生，例如：这里让原生返回一个字符串给到Flutter --- $result");

      return Future<String>.value("Flutter端：接收到iOS的消息！！！");
    });
  }

}