import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'package:jp_flutter_demo/extension/double_extension.dart';

/* 学自：https://juejin.cn/post/6844904176489594893 */

class ScreenFitExample extends StatelessWidget {
  static String title = "20.屏幕适配";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ScreenFitExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: ScreenFitPage(),

    );
  }
}

class ScreenFitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = 300.0.px;
    double h = 200.0.px;
    double fontSize = 40.0.px;
    
    JPrint("width 300 - $w");
    JPrint("height 200 - $h");
    JPrint("fontSize 40 - $fontSize");

    return Center(
      child: Container(
        width: w,
        height: h,
        color: JPRandomColor(),
        alignment: Alignment.center,
        child: Text("Hello, Flutter!", style: TextStyle(fontSize: fontSize, color: JPRandomColor()),),
      ),
    );
  }
}