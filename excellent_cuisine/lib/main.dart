import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:excellent_cuisine/core/route/route.dart';
import 'package:excellent_cuisine/ui/shared/JPAppTheme.dart';
import 'package:excellent_cuisine/core/view_model/favor_view_model.dart';
import 'package:excellent_cuisine/core/view_model/filter_view_model.dart';
import 'package:excellent_cuisine/core/view_model/meal_view_model.dart';

import 'JPLog.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // 不用担心一启动会不会就执行 create 函数（例如创建JPMealViewModel，初始化时会进行网络请求等复杂操作）
        // 因为 create 函数是【懒加载】的，当第一个 Consumer/Selector 使用时才会执行（初始化）。

        // ChangeNotifierProvider(create: (ctx) => JPMealViewModel()),
        // ChangeNotifierProvider(create: (ctx) => JPFavorViewModel()),
        ChangeNotifierProvider(create: (ctx) => JPFilterViewModel()),

        // R 和 T 两个共享状态，设置 R 依赖 T --- T 发生变化时 R 也发生变化
        // 使用 ChangeNotifierProxyProvider 实现依赖关系，并且要声明泛型类型：
        // ChangeNotifierProxyProvider<T, R extends ChangeNotifier>
        // 必传参数1：Create<R> create = R Function(BuildContext context);
        // 必传参数2：ProxyProviderBuilder<T, R> update = R Function(BuildContext context, T value, R previous);

        ChangeNotifierProxyProvider<JPFilterViewModel, JPMealViewModel>(
          create: (ctx) => JPMealViewModel(),
          update: (ctx, filterVM, mealVM) {
            // 当 filterVM 发生变化会来到这里，对 mealVM 做相应处理
            mealVM.filterFor(filterVM); // 在 filterFor 内部调用了 notifyListeners（以前貌似会自动刷新）
            return mealVM;
          },
        ),

        ChangeNotifierProxyProvider<JPFilterViewModel, JPFavorViewModel>(
          create: (ctx) => JPFavorViewModel(),
          update: (ctx, filterVM, favorVM) {
            // 当 filterVM 发生变化会来到这里，对 favorVM 做相应处理
            favorVM.filterFor(filterVM); // 在 filterFor 内部调用了 notifyListeners（以前貌似会自动刷新）
            return favorVM;
          },
        ),

      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "美味佳肴",
      // 配置主题
      theme: JPAppTheme.baseThemeData,
      // 配置路由
      routes: JPRoute.routes,
      onGenerateRoute: JPRoute.onGenerateRoute,
      onUnknownRoute: JPRoute.onUnknownRoute,
      initialRoute: JPRoute.initialRoute,
    );
  }
}
