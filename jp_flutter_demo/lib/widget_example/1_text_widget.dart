import 'package:flutter/material.dart';

/* 学自：https://juejin.cn/post/6844903954514444302 */

class TextWidgetExample extends StatelessWidget {
  static String title = "1.Text";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextWidgetExample.title),
      ),
      body: _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text("《定风波》 苏轼 \n莫听穿林打叶声，何妨吟啸且徐行。\n竹杖芒鞋轻胜马，谁怕？一蓑烟雨任平生。",
          style: TextStyle(fontSize: 25, color: Colors.pink),
          textAlign: TextAlign.center, // 所有内容都居中对齐
          maxLines: 3,
          overflow: TextOverflow.ellipsis, // 超出部分显示...
        ),

        SizedBox(height: 10),
        
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "《定风波》", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue)),
              TextSpan(text: "苏轼", style: TextStyle(fontSize: 18, color: Colors.cyan)),
              TextSpan(text: "\n莫听穿林打叶声，何妨吟啸且徐行。\n竹杖芒鞋轻胜马，谁怕？一蓑烟雨任平生。")
            ],
          ),
          // 没有单独设置的，会统一设置成以下效果
          style: TextStyle(fontSize: 20, color: Colors.orange), 
          textAlign: TextAlign.center,
        )
      ]
    );
  }
}