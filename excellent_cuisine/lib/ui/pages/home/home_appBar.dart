import 'package:flutter/material.dart';

class JPHomeAppBar extends AppBar {

  JPHomeAppBar() : super(
    title: Text("美食广场"),
    // 自定义导航栏左侧按钮，会覆盖原本 Drawer 自带的那个按钮的点击打开事件
    // 需要自己重新添加打开Drawer的点击事件
    // 包裹一层【Builder】，通过子context拿到当前的 Scaffold --- 打开左侧菜单
    leading: Builder(
      builder: (ctx) {
        return IconButton(
          icon: Icon(Icons.money),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
        );
      },
    ),
  );

}