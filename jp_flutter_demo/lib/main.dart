import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jp_flutter_demo/WHY/why_class.dart';
import 'package:jp_flutter_demo/JP/jp_demo.dart';
import 'package:jp_flutter_demo/demo/product_list.dart';
import 'package:jp_flutter_demo/demo/random_words.dart';
import 'package:jp_flutter_demo/douban/main/douban.dart';
import 'package:jp_flutter_demo/demo/stful_example.dart';
import 'package:jp_flutter_demo/demo/json_decode.dart';
import 'package:jp_flutter_demo/widget_example/widget_example.dart';
import 'package:jp_flutter_demo/providers/initialize_providers.dart';
import 'package:jp_flutter_demo/utils/event_bus.dart';
import 'package:jp_flutter_demo/route/route.dart';
import 'package:jp_flutter_demo/shared/JPSizeFit.dart';
import 'providers/navigator_provider.dart';
import 'JPLog.dart';

/*
 * 创建全局的 EventBus 对象，用于跨组件事件传递，全局用一个即可。
 */
final eventBus = EventBus();

/*
 * Provider 三个核心概念：
 * 1.ChangeNotifier：真正数据（状态）存放的地方
 * 2.ChangeNotifierProvider：Widget树中提供数据（状态）的地方，会在其中创建对应的ChangeNotifier
 * 3.Consumer：Widget树中需要使用数据（状态）的地方
 * 
 * Provider 使用步骤：
 * 1.创建自己需要共享的数据；
 * 2.在应用程序的最顶层使用Provider；
 *  - 也就是在 runApp 中使用 ChangeNotifierProvider/MultiProvider 将 主体Widget（MyApp）包裹住，全局共享
 *  - 可以使用 MultiProvider 共享多个 Provider
 * 3.在其他地方使用共享的数据：
 *  3.1 Provider.of: 当Provider中的数据发生改变时, Provider.of所在的Widget整个build方法都会重新构建
 *    - 使用 Provider.of<T>(context) 获取对应的 Provider 对象
 *  3.2 Consumer: 当Provider中的数据发生改变时, 执行重新执行Consumer的builder
 *    - 使用 Consumer 包裹 子Widget，让 子Widget 在里面能直接拿到 viewModel
 *    - 不会重新构建 Consumer 所在的 widget，只会重新构建 Consumer.builder 返回的 widget
 *    - Consumer2：共享两个类型的数据，ConsumerX：共享X个类型的数据
 *  3.3 Selector: 基本功能跟 Consumer 一样
 *    - 比 Consumer 多出：1.selector方法(作用：对原有的数据进行转换) 2.shouldRebuild(作用：要不要重新构建)
 *    - 若 Consumer.builder 返回的 widget 不需要依赖共享数据（样式没变化），可以在 shouldRebuild 中返回false：当共享数据发生变化时不要重新构建
 * 
 * 全局搜索 “此处是 Provider 使用步骤的：xxx” 查看使用方式
 */

// InheritedWidget【全局共用】
class JPDataWidget extends InheritedWidget {
  // 1.定义可共享的 State
  final Widget child;
  final int counter;

  // 2.定义构造方法
  JPDataWidget({required this.counter, Key? key, required this.child}) : super(key: key, child: child);

  // 3.定义一个静态方法，用来获取当前 JPDataWidget
  // 依赖了当前 JPDataWidget 的 Widget，可通过自己的 context（Element）开始去查找祖先的 JPDataWidget
  static JPDataWidget? of(BuildContext context) {
    // dependOnInheritedWidgetOfExactType：
    // 沿着 Element tree，去找到最近的 JPDataWidget 对应的 Element 对象，再从这个 Element 中取出这个 JPDataWidget 对象（Element.widget），返回出去。
    return context.dependOnInheritedWidgetOfExactType<JPDataWidget>();
  }

  // 4.是否通知<依赖了当前 JPDataWidget>的<StatefulWidget-State>发生了改变
  // 抽象方法 需子类实现（必须实现）
  // 返回 true 会触发 State 的 didChangeDependencies 方法（State 重写该方法即可进行监听），返回false不触发。
  @override
  bool updateShouldNotify(JPDataWidget oldWidget) {
    return oldWidget.counter != this.counter; // 自定义什么条件才通知
    // return true;
  }
}

void main() {
  runApp(
    /*
     * 此处是 Provider 使用步骤的：2.在应用程序的最顶层使用Provider
     *  - 使用 ChangeNotifierProvider 将 主体Widget（MyApp）包裹住
     *  - 保证这个Provider提供的所有数据在整个应用程序里面任何地方都能共享
     */

    // ChangeNotifierProvider(
    //   create: (BuildContext context) => JPCounterViewModel(),
    //   child: MyApp()
    // )

    // 使用 MultiProvider 共享多个 Provider
    MultiProvider(
      providers: providers,
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    // 初始化屏幕信息
    // JPSizeFit.initialize();
    // JPrint("----- MyApp -----");
    // final mediaQueryData = MediaQuery.of(context);
    // final screenWidth = mediaQueryData.size.width;
    // final screenHeight = mediaQueryData.size.height;
    // JPrint("screenWidth：$screenWidth");
    // JPrint("screenHeight：$screenHeight");
    // JPrint("----- MyApp -----");

    return MaterialApp(
      // 适用于全局的 BuildContext
      // 在需要使用 context 的地方可直接使用全局维护的 context 进行页面跳转，showLoading，toast 等功能实现。
      navigatorKey: NavigatorProvider.navigatorKey,

      // 配置路由映射表
      // routes：定义名称和路由之间的映射关系，类型为 Map<String, WidgetBuilder>? routes
      // WidgetBuilder = Widget Function(BuildContext context);
      routes: JPRoute.routes,

      // 路由钩子：当某个路由在 routes 找不到时（没有配置），就会来到这里面 --- 用于自由配置路由，例如有参数的情况
      onGenerateRoute: JPRoute.onGenerateRoute,
      // 如果打开的一个路由名称是根本不存在（在 routes 找不到，在 onGenerateRoute 返回 null）
      // 如果没有进行特殊的处理，那么Flutter会报错，使用 onUnknownRoute 跳转到一个统一的错误页面。
      onUnknownRoute: JPRoute.onUnknownRoute,

      // initialRoute：设置应用程序从哪一个路由开始启动
      // 设置了该属性，就不需要再设置 home 属性了，不能两个都设置，会相互冲突。
      initialRoute: JPRoute.initialRoute,
      
      // 不能设置，会跟 initialRoute 冲突
      // home: Home(),

    );
  }
}

class Home extends StatelessWidget {
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {

    //【在这里才拿到状态栏高度，因为这个widget是全屏的】
    JPrint("----- Home0 -----");
    JPrint("${DateTime.now()}, 缩放因子：${JPSizeFit.dpr}");
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    final devicePixelRatio = mediaQueryData.devicePixelRatio;
    final statusBarHeight = mediaQueryData.padding.top;   
    final bottomHeight = mediaQueryData.padding.bottom;

    JPrint("screenWidth：$screenWidth");
    JPrint("screenHeight：$screenHeight");
    JPrint("devicePixelRatio：$devicePixelRatio");
    JPrint("statusBarHeight：$statusBarHeight");
    JPrint("bottomHeight：$bottomHeight");
    JPrint("----- Home1 -----");
    
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter_demo"),
      ),
      body: HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  // 貌似使用 StatelessWidget 无法路由
  @override
  createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {

    // 初始化屏幕信息
    JPSizeFit.initialize(() {
      setState(() {});
    });

    //【在这里是拿不到状态栏高度的，因为这个widget并不是全屏，而是状态栏以下的区域】
    JPrint("----- HomeContent0 -----");
    JPrint("${DateTime.now()}, 缩放因子：${JPSizeFit.dpr}");
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    final devicePixelRatio = mediaQueryData.devicePixelRatio;
    final statusBarHeight = mediaQueryData.padding.top;   
    final bottomHeight = mediaQueryData.padding.bottom;

    JPrint("screenWidth：$screenWidth");
    JPrint("screenHeight：$screenHeight");
    JPrint("devicePixelRatio：$devicePixelRatio");
    JPrint("statusBarHeight：$statusBarHeight");
    JPrint("bottomHeight：$bottomHeight");
    JPrint("----- HomeContent1 -----");

    return ListView(
      children: [

        ListTile(
          title: Text(
            RandomWords.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(RandomWords());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            ProductList.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(ProductList());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            DoubanApp.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(DoubanApp(), isFullscreenDialog: true);
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            StatefulWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(StatefulWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            JSONDecodeWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(JSONDecodeWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            WidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(WidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            WHYClass.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(WHYClass());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            JPDemo.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(JPDemo());
          },
        ),

      ],
    );
  }

  void _push(Widget widget, {bool isFullscreenDialog = false}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => widget,
        fullscreenDialog: isFullscreenDialog
      ),
    );
  }
}
