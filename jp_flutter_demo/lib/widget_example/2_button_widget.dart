import 'package:flutter/material.dart';

/* 学自：https://juejin.cn/post/6844903954514444302 */

class ButtonWidgetExample extends StatelessWidget {
  static String title = "Button";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ButtonWidgetExample.title),
      ),
      body: _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: 1, // 如果有多个 FloatingActionButton 会导致 heroTag 的冲突，要分别设置跟其他不一样的 heroTag
            child: Text("FloatingActionButton"),
            onPressed: () => print("FloatingActionButton did click"),
          ),

          FloatingActionButton(
            heroTag: 2, // 如果有多个 FloatingActionButton 会导致 heroTag 的冲突，要分别设置跟其他不一样的 heroTag
            child: Text("FloatingActionButton"),
            onPressed: () => print("FloatingActionButton did click"),
          ),

          SizedBox(height: 10,),
          RaisedButton(
            child: Text("RaisedButton"),
            onPressed: () => print("RaisedButton did click"),
          ),

          SizedBox(height: 10,),
          FlatButton(
            child: Text("FlatButton"),
            onPressed: () => print("FlatButton did click"),
          ),

          SizedBox(height: 10,),
          OutlineButton(
            child: Text("OutlineButton"),
            onPressed: () => print("OutlineButton did click"),
          ),

          SizedBox(height: 10,),
          RaisedButton(
            child: Text("Custom - RaisedButton"), 
            textColor: Colors.white,
            color: Colors.green,
            highlightColor: Colors.pink[700], // 高亮颜色
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // 圆角的实现
            elevation: 30, // 阴影大小
            onPressed: () => print("Custom RaisedButton did click"),
          )
        ],
      )
    );
  }
}
