import 'package:flutter_boost/flutter_boost.dart';
import 'dart:ui';

import '../pages/JP/1_bottom_sheet.dart';
import '../pages/JP/2_center_aleat.dart';
import '../pages/JP/jp_demo.dart';
import '../pages/JP/jp_main.dart';
import '../shared/JPLog.dart';
import 'JPBoostNavigatorObserver.dart';

class JPFlutterBoost {
  static FlutterBoost get fbs => FlutterBoost.singleton;

  // ignore: non_constant_identifier_names
  static VoidCallback _testVcb;
  
  static void register() {
    // 配置路由
    fbs.registerPageBuilders({
      JPMainPage.routeName: (pageName, params, _) => JPMainPage(),
      JPDemo.routeName: (pageName, params, _) => JPDemo(),
      JPBottomSheetExample.routeName: (pageName, params, _) => JPBottomSheetExample(),
      JPCenterAleatExample.routeName: (pageName, params, _) => JPCenterAleatExample(),
    });
    
    // 监听导航状态
    fbs.addBoostNavigatorObserver(JPBoostNavigatorObserver());
  
    // 监听原生的Flutter容器的操作 --- ContainerOperation { Push, Onstage, Pop, Remove }
    // fbs.addContainerObserver((operation, settings) {});

    // 监听原生的Flutter容器的生命周期
    // fbs.addBoostContainerLifeCycleObserver((state, settings) {});

    // 监听、接收原生发出的消息
    // ignore: missing_return
    fbs.channel.addEventListener('event_sendFrom_native_test', (name, arguments) {
      JPrint("Flutter 接收到 iOS 发出的消息 --- name: $name, arguments: $arguments");
    });

    // ignore: missing_return
    _testVcb = FlutterBoost.singleton.channel.addEventListener("event_sendFrom_native", (name, arguments) {
      JPrint("【测试】：重复接收到 event_sendFrom_native，然后移除该事件的接收，会导致【这一次】的事件传递中断！也就是说 JPMessageViewModel 不会接收到！要等下一次！");
      _testVcb();
    });
  }

  // static void sendEvent() {
  //   fbs.channel.sendEvent("event_sendFrom_flutter", {"message": "Flutter -> iOS -> Flutter"});
  // }

  // static VoidCallback addEventListener() {
  //   fbs.channel.sendEvent("event_sendFrom_flutter", {"message": "Flutter -> iOS -> Flutter"});
  // }
}