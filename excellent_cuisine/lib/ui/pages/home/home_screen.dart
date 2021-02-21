import 'package:flutter/material.dart';

import 'home_content.dart';
import 'package:excellent_cuisine/JPLog.dart';
// import 'package:excellent_cuisine/ui/pages/home/home_appBar.dart';
// import 'package:excellent_cuisine/ui/pages/home/home_drawer.dart';

class JPHomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      // appBar: JPHomeAppBar(),
      appBar: AppBar(
        title: Text("美食广场"),

        // 自定义导航栏左侧按钮，会覆盖原本 Drawer 自带的那个按钮的点击打开事件
        // 需要自己重新添加打开Drawer的点击事件
        leading: IconButton(
          icon: Icon(Icons.settings),
          // drawer 是通过 ScaffoldState 来驱动的，直接使用GlobalKey打开就完事了
          // onPressed: () => openDrawer(), 

          // 想要 drawer 能覆盖全屏，那就把 drawer 放到 JPMainScreen 上
          // 因为 JPMainScreen 是父组件，所以可以在这里通过当前 context 直接找到 JPMainScreen.Scaffold
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),

        /*
          leading: IconButton(
            icon: Icon(Icons.money),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
         * 此时直接使用 Scaffold.of(context) 是获取不了当前的 Scaffold
         * 因为这个 context 是属于上一层的 widget 的，当然没有 Scaffold，就算有也不是当前这个 Scaffold
         * 使用【Builder】多包裹一层：
          leading: Builder(
            builder: (ctx) {
              return IconButton(
                icon: Icon(Icons.money),
                // 通过【里面的子context】ctx 就可以获取到当前的 Scaffold 了
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              );
            },
          ),
         * 
         * 以下这两种也是同样的道理：
         * Navigator.of(context)
         * Theme.of(context)
         */
      ),
      
      // 想要 drawer 能覆盖全屏，那就把 drawer 放到 JPMainScreen 上
      // drawer: JPHomeDrawer(),

      body: JPHomeContent(),

    );
  }

  void openDrawer() {
    if (_scaffoldKey.currentState.isDrawerOpen) return;
    JPrint("打开左侧菜单");
    _scaffoldKey.currentState.openDrawer();
  }

  void closeDrawer() {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      JPrint("关闭左侧菜单");
      Navigator.of(_scaffoldKey.currentContext).pop();
    }
  }
}