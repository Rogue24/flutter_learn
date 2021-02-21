import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844904176321839118 */

class AnimationTransitionExample extends StatelessWidget {
  static String title = "动画 Transition";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AnimationTransitionExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("Modal", style: TextStyle(fontSize: 20, color: JPRandomColor())),
              color: JPRandomColor(),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => _AnimationModalPage("Modal"),
                    // 设置 true，类似 iOS 的 Modal 方式弹出
                    fullscreenDialog: true 
                  ),
                );
              },
            ),

            SizedBox(height: 8,),
            RaisedButton(
              child: Text("Fade", style: TextStyle(fontSize: 20, color: JPRandomColor())),
              color: JPRandomColor(),
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 1), // push 转场时长
                    reverseTransitionDuration: Duration(seconds: 3), // pop 转场时长
                    pageBuilder: (context, animation1, animation2) {
                      return FadeTransition(
                        // opacity 是 Animation 类型，可以自定义 Animation，也可以直接使用 PageRouteBuilder 提供的 Animation
                        // animation1 可以实现渐变效果，而 animation2 目前还不清楚是怎么用，会直接黑屏
                        opacity: animation1, 
                        child: _AnimationModalPage("Fade"),
                      );
                    } 
                  )
                );
              },
            ),
          ],
        )
      ),
      
    );
  }
}

class _AnimationModalPage extends StatelessWidget {
  final String title;

  _AnimationModalPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: Center(child: Text("欢迎光临", style: TextStyle(fontSize: 30, color: JPRandomColor()))),

    );
  }
}