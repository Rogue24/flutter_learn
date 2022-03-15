
import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/main.dart';
import 'package:jp_flutter_demo/douban/main/douban.dart';
import 'package:jp_flutter_demo/demo/product_list.dart';
import 'package:jp_flutter_demo/demo/random_words.dart';
import 'package:jp_flutter_demo/WHY/9_MaterialPageRoute.dart';
import 'package:jp_flutter_demo/route/unknown.dart';
import 'package:jp_flutter_demo/widget_example/5_form_widget.dart';

class JPRoute {
  // 配置路由映射表
  // routes：定义名称和路由之间的映射关系，类型为 Map<String, WidgetBuilder>? routes
  //  - key：路由名 String
  //  - value：路由widget的生成器 WidgetBuilder = Widget Function(BuildContext context);
  // PS：这里配置好的路由都是以默认的推出方式（从左到右）进行过渡
  static final Map<String, WidgetBuilder> routes = {
    // "/": (ctx) => Home(),
    Home.routeName: (ctx) => Home(),

    // "/douban": (ctx) => DoubanApp(),
    DoubanApp.routeName: (ctx) => DoubanApp(),

    // "/product_list": (ctx) => ProductList(),
    ProductList.routeName: (ctx) => ProductList(),

    // "/random_words": (ctx) => RandomWords(),
    RandomWords.routeName: (ctx) => RandomWords(),

    // "/form_page_demo": (ctx) => FormWidgetExample(),
    FormWidgetExample.routeName: (ctx) => FormWidgetExample(),
  };

  // 路由钩子：当某个路由在 routes 找不到时（没有配置），就会来到这里面。
  // 适用于自由配置路由，例如：有特定参数处理、或者想自定义过渡方式等情况
  // RouteFactory = Route<dynamic>? Function(RouteSettings settings);
  static final RouteFactory onGenerateRoute = (settings) {
    if (settings.name == TestPageDemo.routeName) {
      return MaterialPageRoute(
        builder: (context) {
          String arguments = settings.arguments as String;
          return TestPageDemo(arguments);
        },
      );
    }
    return null;
  };
  // 如果打开的一个路由名称是根本不存在（在 routes 找不到，在 onGenerateRoute 返回 null）
  // 如果没有进行特殊的处理，那么Flutter会报错
  // 使用 onUnknownRoute 跳转到一个统一的错误页面
  static final RouteFactory onUnknownRoute = (settings) {
    return MaterialPageRoute(
      builder: (context) {
        return JPUnknownPage(settings);
      }
    );
  };

  // initialRoute：设置应用程序从哪一个路由开始启动
  // 设置了该属性，MaterialApp 就不需要再设置 home 属性了，不能同时设置，会相互冲突。
  static final String initialRoute = Home.routeName;
}

