import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844904175185166349 */

class GestureExample extends StatelessWidget {
  static String title = "手势识别 Gesture";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          GestureExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: _GestureDemo(),
      
    );
  }
}

class _GestureDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          width: 200,
          height: 200,
          color: JPRandomColor(),
        ),
        
        onTapDown: (details) {
          JPrint("onTapDown globalPosition: ${details.globalPosition}"); // 相对于【屏幕】
          JPrint("onTapDown localPosition: ${details.localPosition}"); // 相对于【子Widget】
        }, // 手指按下
        onTapUp: (details) => JPrint("onTapUp: $details"), // 手指抬起
        onTap: () => JPrint("onTap"), // 点击事件完成（onTapDown开始，onTapUp结束后）
        onTapCancel: () => JPrint("onTapCancel"), // 点击事件被取消

        onDoubleTap: () => JPrint("onDoubleTap"), // 双击

      ),
    );
  }
}