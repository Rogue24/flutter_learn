import 'package:flutter/material.dart';

import 'package:excellent_cuisine/core/route/unknown.dart';
import 'package:excellent_cuisine/ui/pages/main/main_screen.dart';
import 'package:excellent_cuisine/ui/pages/detail/detail_screen.dart';
import 'package:excellent_cuisine/ui/pages/meal/meal_screen.dart';
import 'package:excellent_cuisine/ui/pages/filter/filter_screen.dart';

class JPRoute {
  // 配置路由映射表
  // routes：定义名称和路由之间的映射关系，类型为 Map<String, WidgetBuilder>? routes
  //  - key：路由名 String
  //  - value：路由widget的生成器 WidgetBuilder = Widget Function(BuildContext context);
  // PS：这里配置好的路由都是以默认的推出方式（从左到右）进行过渡
  static final Map<String, WidgetBuilder> routes = {
    JPMainScreen.routeName: (ctx) => JPMainScreen(),
    JPMealScreen.routeName: (ctx) => JPMealScreen(),
    JPDetailScreen.routeName: (ctx) => JPDetailScreen(),
  };

  // 路由钩子：当某个路由在 routes 找不到时（没有配置），就会来到这里面。
  // 适用于自由配置路由，例如：有特定参数处理、或者想自定义过渡方式等情况
  // RouteFactory = Route<dynamic>? Function(RouteSettings settings);
  static final RouteFactory onGenerateRoute = (settings) {
    if (settings.name == JPFilterScreen.routeName) {
      // 从下而上弹出
      return MaterialPageRoute(
        builder: (context) => JPFilterScreen(),
        // 设置 true，类似 iOS 的 Modal 方式弹出
        fullscreenDialog: true 
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
  static final String initialRoute = JPMainScreen.routeName;
}

