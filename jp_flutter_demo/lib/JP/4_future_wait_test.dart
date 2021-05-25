import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

class JPFutureWaitExample extends StatelessWidget {
  static String title = "Future.wait Example";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPFutureWaitExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: () => JPFutureWait.test(),
      ),

    );
  }
}

class JPFutureWait {
  static void test() async {
    JPrintWiteDate("开始全部请求 111");
    await Future.wait([
      subTest("1").then((value) => JPrintWiteDate("结束请求 $value")),
      subTest("2").then((value) => JPrintWiteDate("结束请求 $value")),
      subTest("3").then((value) => JPrintWiteDate("结束请求 $value")),
      subTest("4").then((value) => JPrintWiteDate("结束请求 $value")),
      subTest("5").then((value) => JPrintWiteDate("结束请求 $value")),
    ]);
    JPrintWiteDate("结束全部请求 111");

    sleep(Duration(seconds: 1));

    JPrintWiteDate("开始全部请求 222");
    await Future.wait([
      subTest("1").then((value) => JPrintWiteDate("结束请求 $value")),
      subTest("2").then((value) => JPrintWiteDate("结束请求 $value")),
      subTest("3").then((value) => JPrintWiteDate("结束请求 $value")),
      subTest("4").then((value) => JPrintWiteDate("结束请求 $value")),
      subTest("5").then((value) => JPrintWiteDate("结束请求 $value")),
    ]);
    JPrintWiteDate("结束全部请求 222");
  }

  static Future<String> subTest(String str) async {
    var delay = 1 + Random().nextInt(5);
    JPrintWiteDate("开始请求 $str, 延时$delay秒");
    await Future.delayed(Duration(seconds: delay));
    return str;
  }
}