import 'package:flutter/material.dart';

class JPAppTheme {
  static const double fontSize15 = 15;
  static const double fontSize20 = 20;
  static const double fontSize25 = 25;
  static const double fontSize30 = 30;
  static const double fontSize35 = 35;
  static const double fontSize40 = 40;

  static final ThemeData baseThemeData = ThemeData(
    // 脚手架背景色
    scaffoldBackgroundColor: Colors.white,

    // 主颜色（只能设置 MaterialColor 类型，是 primaryColor + accentColor 的结合体）
    primarySwatch: Colors.blue,

    // 默认高亮时会有个波纹（安卓那种），设置颜色透明移除这个波纹
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    // 底部Tabbar主题
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.yellowAccent
    ),

    // 按钮主题
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue
    ),

    // 卡片主题
    cardTheme: CardTheme(
      color: Colors.blue,
    ),

    // 文本主题
    textTheme: TextTheme(
      bodyText2: TextStyle(fontSize: fontSize15, color: Colors.black45), // 默认 Style（以前是 body1）

      headline1: TextStyle(fontSize: fontSize15),
      headline2: TextStyle(fontSize: fontSize20),
      headline3: TextStyle(fontSize: fontSize25),
      headline4: TextStyle(fontSize: fontSize30),
      headline5: TextStyle(fontSize: fontSize35),
      headline6: TextStyle(fontSize: fontSize40),
    ),
  );

  static final ThemeData dartThemeData = ThemeData(
    // 脚手架背景色
    scaffoldBackgroundColor: Colors.grey,
    
    // 主颜色（只能设置 MaterialColor 类型，是 primaryColor + accentColor 的结合体）
    primarySwatch: Colors.brown,

    // 默认高亮时会有个波纹（安卓那种），设置颜色透明移除这个波纹
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    // 底部Tabbar主题
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.teal
    ),

    // 按钮主题
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueGrey
    ),

    // 卡片主题
    cardTheme: CardTheme(
      color: Colors.blueGrey,
    ),

    // 文本主题
    textTheme: TextTheme(
      bodyText2: TextStyle(fontSize: fontSize15, color: Colors.white70), // 默认 Style（以前是 body1）

      headline1: TextStyle(fontSize: fontSize15),
      headline2: TextStyle(fontSize: fontSize20),
      headline3: TextStyle(fontSize: fontSize25),
      headline4: TextStyle(fontSize: fontSize30),
      headline5: TextStyle(fontSize: fontSize35),
      headline6: TextStyle(fontSize: fontSize40),
    ),
  );
}