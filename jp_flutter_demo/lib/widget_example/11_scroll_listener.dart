import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844903957739864078 */

class ScrollListenerExample extends StatelessWidget {
  static String title = "Scroll Listener";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ScrollListenerExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
      backgroundColor: Colors.teal,

      // 切换Widget看demo
      // body: _ScrollControllerDemo()
      body: _NotificationListenerDemo()
    );
  }
}

/*
 * NotificationListener 是一个 Widget，泛型 T 是想监听的通知类型，如果省略，则所有类型通知都会被监听，如果指定特定类型，则只有该类型的通知会被监听。
 * NotificationListener 需要一个 onNotification 回调函数，用于实现监听处理逻辑。
 * onNotification 可以返回一个布尔值，代表是否阻止该事件继续向上冒泡，如果为 true 时，则冒泡终止，事件停止向上传播，如果不返回或者返回值为 false 时，则冒泡继续。
 */

// 案例：显示列表滚动的进度
class _NotificationListenerDemo extends StatefulWidget {
  @override
  __NotificationListenerDemoState createState() => __NotificationListenerDemoState();
}

class __NotificationListenerDemoState extends State<_NotificationListenerDemo> {
  int _progress = 0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification noti) {
        // 这里没有指定 T 是什么类型，所有类型的通知都会被监听，
        // 因此如果这里返回 true，就不会继续传递事件到其他通知

        if (noti is ScrollStartNotification) {
          JPrint("开始滚动");

        } else if (noti is ScrollUpdateNotification) {
          // 当前滚动的位置和总长度
          final currentPixel = noti.metrics.pixels;
          final totalPixel = noti.metrics.maxScrollExtent;

          // 计算当前滚动的进度
          double progress = currentPixel / totalPixel;
          setState(() {
            _progress = (progress * 100).toInt();
          });

        } else if (noti is ScrollEndNotification) {
          JPrint("结束滚动");
        }

        return false;
      },

      child: Stack(
        alignment: Alignment(0.9, 0.9), // 有固定尺寸的 widget 就按照这个对齐方式摆放
        children: [
          ListView.builder(
            itemCount: 100,
            itemExtent: 60,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text("第${index + 1}个"),);
            },
          ),
          CircleAvatar(
            radius: 30,
            child: Text("$_progress%"),
            backgroundColor: Colors.yellow,
          )
        ],
      ),
    );
  }
}


/*
 * ListView、GridView 的组件控制器是 ScrollController
 * ScrollController 间接继承自 Listenable
 * 可以通过 ScrollController 来获取视图的滚动信息，并且可以调用里面的方法来更新视图的滚动位置。
 * 通常情况下会根据滚动的位置来改变一些 Widget 的状态信息，所以 ScrollController 通常会和 StatefulWidget 一起来使用，控制 Widget 的初始化、监听、销毁等事件。
 */

// 案例：当滚动到 1000 位置的时候，显示一个点击能回到顶部的按钮，否则隐藏
class _ScrollControllerDemo extends StatefulWidget {
  @override
  _ScrollControllerDemoState createState() => _ScrollControllerDemoState();
}

class _ScrollControllerDemoState extends State<_ScrollControllerDemo> {
  ScrollController _controller;
  bool _isShowTop = false;

  @override
  void initState() {
    // 初始化 ScrollController
    _controller = ScrollController();
    // 监听滚动
    _controller.addListener((){
      // print("offset: ${_controller.offset}");
      var isShowTop = _controller.offset >= 1000;
      if (isShowTop != _isShowTop) setState(() => _isShowTop = isShowTop);
    });

    super.initState();
  }

  List<Widget> getWidgets() {
    List<Widget> widgets = [
      ListView.builder(
        itemCount: 100,
        itemExtent: 60,
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text("第${index + 1}个"),);
        },
      )
    ];

    if (_isShowTop) {
      widgets.add(
        Positioned(
          bottom: 80,
          right: 10,
          child: FloatingActionButton(
            child: Icon(Icons.arrow_upward),
            onPressed: () {
              JPrint("回到顶部");
              _controller.animateTo(0, duration: Duration(seconds: 1), curve: Curves.ease);
            },
          ),
        )
      );
    }

    return widgets;
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: getWidgets(),
    );
  }
}