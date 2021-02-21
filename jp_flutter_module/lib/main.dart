import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jp_flutter_module/flutterboost/JPBoostNavigatorObserver.dart';
import 'package:jp_flutter_module/pages/JP/1_bottom_sheet.dart';
import 'package:jp_flutter_module/pages/JP/2_center_aleat.dart';
import 'package:jp_flutter_module/pages/JP/jp_demo.dart';
import 'package:jp_flutter_module/pages/JP/jp_main.dart';
import 'package:jp_flutter_module/shared/JPLog.dart';
import 'package:jp_flutter_module/shared/JPSizeFit.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:jp_flutter_module/view_model/ios_message_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => JPMessageViewModel(),
      child: MyApp(),
    )
  );
}

// ignore: slash_for_doc_comments
/**
 * 0.Xcode/Android-Studio启动项目；
 * 
 * 1.终端输入：【flutter attach -d 模拟器/设备ID --app-id 应用ID】，连接原生工程+启动热更新；
 * 🌰🌰🌰：flutter attach -d 7EE646A8-9F4C-4415-9412-F94044FA328C --app-id zhoujianping.JPFlutterModule
 * 不知道设备ID的话先敲 flutter attach，会有ID列表看
 * 
 * 2.修改、保存代码后，在终端输入：【r】热更新，【R】热启动。
 */

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    JPrint("初始化 Flutter ~");

    return MaterialApp(
      title: 'Flutter Demo',

      // 创建 FlutterBoost ！！！
      builder: FlutterBoost.init(),

      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    
    JPrint("初始化 FlutterBoost ~");

    // 接收原生发出的数据
    // ignore: missing_return
    FlutterBoost.singleton.channel.addEventListener('event_sendFrom_native_test', (name, arguments) {
      JPrint("Flutter 接收到 iOS 发出的消息 --- name: $name, arguments: $arguments");
    });
    
    // 配置路由
    FlutterBoost.singleton.registerPageBuilders({
      JPMainPage.routeName: (pageName, params, _) => JPMainPage(),
      JPDemo.routeName: (pageName, params, _) => JPDemo(),
      JPBottomSheetExample.routeName: (pageName, params, _) => JPBottomSheetExample(),
      JPCenterAleatExample.routeName: (pageName, params, _) => JPCenterAleatExample(),
    });
  }

  @override
  Widget build(BuildContext context) {
    // 混编就得确定【Widget能初始化时】才初始化屏幕信息
    JPSizeFit.initialize();
    
    return Container(color: JPRandomColor(),);
  }

  

  
}


/**
 * 1、如果在IOS端只是第一次打开Flutter页面用Boost的路由然后FlutterA跳转到FlutterB用的Navigator的话，当前右滑会直接pop掉所有Flutter页面，因为这种情况只有一个VC承载Flutter页面，推荐Native->Flutter，FlutterA->FlutterB，Flutter->Native都用Boost路由管理
 * 
 * 2、移除addEventListener，移除addBoostContainerLifeCycleObserver。addEventListener方法会返回一个FLBVoidCallback，执行这个FLBVoidCallback就会移除；addBoostContainerLifeCycleObserver会返回一个VoidCallback，在dispose()中调用VoidCallback就remove了
 * 
 * 3、Flutter调Native后获取Native回传。channel肯定可以的，boost目前默认应该只支持FlutterA->FlutterB的回传，Flutter->Native和Native->Flutter可以自己实现。下面是FlutterA->FlutterB的回传方式
 * 
 */

/**
 * FlutterA打开FlutterB：
    FlutterBoost.singleton
        .open('FlutterB')
        .then((Map<dynamic, dynamic> value) {
      print(
          'call me when page is finished. did recieve FlutterB route result $value');
    });
 *
 * FlutterB close并回传：
    final BoostContainerSettings settings = BoostContainer.of(context).settings;
    FlutterBoost.singleton.close(settings.uniqueId, result: <String, dynamic>{'result': 'data from FlutterB'});
 */