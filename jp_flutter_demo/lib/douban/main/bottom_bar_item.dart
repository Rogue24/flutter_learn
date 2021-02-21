import 'package:flutter/material.dart';

class JPBottomBarItem extends BottomNavigationBarItem {
  JPBottomBarItem(String iconName, String title) : super(
    // 字体颜色默认跟随着主题颜色
    label: title, 
    // title: Text(title),

    // gaplessPlayback：切换图片时是否等到新的图片加载完之后才移除当前图片
    // 默认是false，会立马移除当前图片，这样就会造成第一次切换时会有闪烁的情况，因为新图片加载需要一点时间
    icon: Image.asset("assets/images/tabbar/$iconName.png", width: 32, gaplessPlayback: true),
    activeIcon: Image.asset("assets/images/tabbar/${iconName}_active.png", width: 32, gaplessPlayback: true)
  );
}