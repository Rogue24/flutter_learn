import 'package:flutter/material.dart';

import 'package:excellent_cuisine/ui/shared/JPSizeFit.dart';
import 'package:excellent_cuisine/ui/shared/JPAppTheme.dart';
import 'package:excellent_cuisine/ui/pages/main/main_initialize.dart';
// import 'package:excellent_cuisine/ui/pages/home/home_screen.dart';
import 'package:excellent_cuisine/ui/pages/home/home_drawer.dart';

class JPMainScreen extends StatefulWidget {
  static const String routeName = "/";

  @override
  _JPMainScreenState createState() => _JPMainScreenState();
}

class _JPMainScreenState extends State<JPMainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    // 初始化适配信息
    JPSizeFit.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: IndexedStack(
        index: _currentIndex,
        children: mainPages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        // 选中&非选中 字体保持大小一致
        selectedFontSize: JPAppTheme.baseFontSize,
        unselectedFontSize: JPAppTheme.baseFontSize,
        // 选中&非选中 字体颜色
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        // 背景色
        backgroundColor: Colors.indigo,

        currentIndex: _currentIndex,
        items: mainItems,
        onTap: (index) => setState(() => _currentIndex = index),
        // onTap: (index) {
        //   if (index != 0) {
        //     JPHomeScreen homeScreen = mainPages[0];
        //     homeScreen.closeDrawer();
        //   }
        //   setState(() => _currentIndex = index);
        // }
      ),

      // 想要 drawer 能覆盖全屏，那就把 drawer 放到 JPMainScreen 上
      drawer: JPHomeDrawer(),

    );
  }
}