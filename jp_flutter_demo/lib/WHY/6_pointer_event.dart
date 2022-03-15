import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844904175185166349 */

class PointerEventExample extends StatelessWidget {
  static String title = "6.Pointer Event";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          PointerEventExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: _PointerEventDemo(),
      
    );
  }
}

class _PointerEventDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        child: Container(
          width: 200,
          height: 200,
          color: JPRandomColor(),
        ),

        onPointerDown: (event) {
          JPrint("手指down position: ${event.position}"); // 相对于【屏幕】
          JPrint("手指down localPosition: ${event.localPosition}"); // 相对于【子Widget】
        },
        onPointerMove: (event) => JPrint("手指move: ${event.localPosition}"),
        onPointerUp: (event) => JPrint("手指up: ${event.position}"),

        onPointerSignal: (event) => JPrint("onPointerSignal: $event"),
        onPointerCancel: (event) => JPrint("onPointerCancel: $event"),
        onPointerHover: (event) => JPrint("onPointerHover: $event"),
      ),
    );
  }
}