import 'package:flutter/material.dart';

class JPAppTheme {
  // ------------ 公用属性 ------------
  static const double baseFontSize = 14;
  static const double smallFontSize = 16;
  static const double normalFontSize = 20;
  static const double largeFontSize = 24;

  // ------------ 亮色模式 ------------
  static final ThemeData baseThemeData = ThemeData(
    // 主颜色（只能设置 MaterialColor 类型，是 primaryColor + accentColor 的结合体）
    primarySwatch: Colors.indigo,
    // 次颜色：用于单独设置 FloatingActionButton 和 Switch 的颜色（不设置则会使用 primarySwatch）
    accentColor: Colors.pink,

    // 默认背景色
    canvasColor: Color.fromRGBO(240, 240, 240, 1), // ,

    // 默认高亮时会有个波纹（安卓那种），设置颜色透明移除这个波纹
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    // 文本主题
    textTheme: TextTheme(
      bodyText2: TextStyle(fontSize: baseFontSize), // 默认 Style（以前是 body1）
      headline1: TextStyle(fontSize: smallFontSize),
      headline2: TextStyle(fontSize: normalFontSize),
      headline3: TextStyle(fontSize: largeFontSize),
    ),
  );

  // ------------ 深色模式 ------------
  // static final ThemeData dartThemeData = ThemeData();
}