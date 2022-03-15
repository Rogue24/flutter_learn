import 'package:flutter/material.dart';

/* 学自：https://juejin.cn/post/6844903954514444302 */

class ButtonWidgetExample extends StatelessWidget {
  static String title = "2.Button";

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
          ElevatedButton(
            child: Text("ElevatedButton"),
            onPressed: () => print("ElevatedButton did click"),
          ),

          SizedBox(height: 10,),
          TextButton(
            child: Text("TextButton"),
            onPressed: () => print("TextButton did click"),
          ),

          SizedBox(height: 10,),
          OutlinedButton(
            child: Text("OutlinedButton"),
            onPressed: () => print("OutlinedButton did click"),
          ),

          SizedBox(height: 10,),
          ElevatedButton(
            child: Text("Custom - ElevatedButton"), 
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.green),
                overlayColor: MaterialStateProperty.all(Colors.pink[700]), // 高亮颜色
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), // 圆角的实现
                elevation: MaterialStateProperty.all(10), // 阴影大小
              ),
            onPressed: () => print("Custom ElevatedButton did click"),
          )
        ],
      )
    );
  }
}
