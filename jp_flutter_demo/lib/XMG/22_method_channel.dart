import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jp_flutter_demo/JPLog.dart';
// import 'package:jp_flutter_demo/extension/double_extension.dart';

class MethodChannelExample extends StatelessWidget {
  static String title = "方法通道 调用原生方法";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MethodChannelExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: _MethodChannelPage(),

    );
  }
}

class _MethodChannelPage extends StatefulWidget {
  @override
  __MethodChannelPageState createState() => __MethodChannelPageState();
}

class __MethodChannelPageState extends State<_MethodChannelPage> {
  // 核心代码一：创建一个全局静态的 MethodChannel 对象。
  // 传入的name要唯一，该name是用来区分多个不同【通信/功能/模块】的名称，命名规范：域名/功能
  static const platform = const MethodChannel("zhoujianping.com/battery"); 

  // 这个 name 是用来在 iOS/Android 里面创建对应的 FlutterMethodChannel：
  // let channel = FlutterMethodChannel(name: "zhoujianping.com/battery", binaryMessenger: ctr.binaryMessenger)

  String _batteryInfo = "0";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text("获取电池信息"),
            onPressed: getBatteryInfo,
          ),
          Text("当前电量：$_batteryInfo"),
        ],
      ),
    );
  }

  void getBatteryInfo() async {
    JPrint("去原生平台获取电池信息");

    // 核心代码二：通过调用 MethodChannel 对象的 invokeMethod（唤醒、调用）来给对应的平台发送消息进行通信。
    try {
      final result = await platform.invokeMethod("getBatteryInfo");
      JPrint("获取成功 --- $result");
      setState(() => _batteryInfo = "$result%");

    // } on PlatformException catch(exc) { 
    // // 这样写的话，不是 PlatformException 就不会来到这里面，要另外写再写一个{}
    // }

    } catch(error) {
      if (error is PlatformException) {
        PlatformException exc = error;
        JPrint("获取失败（PlatformException）--- ${exc.message}");
        setState(() => _batteryInfo = "${exc.message}");
      } else {
        JPrint("获取失败（Error） --- $error");
        setState(() => _batteryInfo = "$error");
      }
    }

    // 成功或异常都会继续来到这里，不会中途退出
    JPrint("hi");
  }
}