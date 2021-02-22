import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:jp_flutter_module/shared/JPLog.dart';

class JPMessageViewModel extends ChangeNotifier {

  String _message = "";

  set message(String value) {
    _message = value;
    notifyListeners(); // 通知所有监听者
  }
  String get message => _message;

  JPMessageViewModel() {
    JPrint("初始化 JPMessageViewModel ！！！");
    // 监听、接收 iOS 发来的消息
    // ignore: missing_return
    FlutterBoost.singleton.channel.addEventListener("event_sendFrom_native", (name, arguments) {
      JPrint("【监听】：接收到 event_sendFrom_native，通知所有监听者！！！");
      message = arguments["message"];
    });
  }
}