import 'package:flutter_boost/flutter_boost.dart';

import '../pages/JP/1_bottom_sheet.dart';
import '../pages/JP/2_center_aleat.dart';
import '../pages/JP/jp_demo.dart';
import '../pages/JP/jp_main.dart';
import '../shared/JPLog.dart';
import 'JPBoostNavigatorObserver.dart';

class JPFlutterBoost {
  
  static void register() {
    // 配置路由
    FlutterBoost.singleton.registerPageBuilders({
      JPMainPage.routeName: (pageName, params, _) => JPMainPage(),
      JPDemo.routeName: (pageName, params, _) => JPDemo(),
      JPBottomSheetExample.routeName: (pageName, params, _) => JPBottomSheetExample(),
      JPCenterAleatExample.routeName: (pageName, params, _) => JPCenterAleatExample(),
    });
    
    // 监听导航状态
    FlutterBoost.singleton.addBoostNavigatorObserver(JPBoostNavigatorObserver());
  
    // 监听原生的Flutter容器的操作 --- ContainerOperation { Push, Onstage, Pop, Remove }
    // FlutterBoost.singleton.addContainerObserver((operation, settings) {});

    // 监听原生的Flutter容器的生命周期
    // FlutterBoost.singleton.addBoostContainerLifeCycleObserver((state, settings) {});

    // 监听、接收原生发出的消息
    // ignore: missing_return
    FlutterBoost.singleton.channel.addEventListener('event_sendFrom_native_test', (name, arguments) {
      JPrint("Flutter 接收到 iOS 发出的消息 --- name: $name, arguments: $arguments");
    });
  }
}