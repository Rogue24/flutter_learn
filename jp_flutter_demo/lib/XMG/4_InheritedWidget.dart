import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/main.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844904174115618830 */

// JPDataWidget 用于全局共享，定义在 main.dart，继承于 InheritedWidget

class InheritedWidgetExample extends StatelessWidget {
  static String title = "InheritedWidget";

  final GlobalKey<__InheritedWidgetDemoState> gbKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          InheritedWidgetExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: _InheritedWidgetDemo(gbKey),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          var state = gbKey.currentState;
          // ignore: invalid_use_of_protected_member
          state.setState(() => state.counter += 1);
        },
      )
    );
  }
}

class _InheritedWidgetDemo extends StatefulWidget {
  @override
  __InheritedWidgetDemoState createState() => __InheritedWidgetDemoState();

  // key 是父类 StatefulWidget 的可选参数，本身没有就得自定义构造方法
  _InheritedWidgetDemo(Key key) : super(key: key);
}

class __InheritedWidgetDemoState extends State<_InheritedWidgetDemo> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    // 若 父Widget 不是 JPDataWidget，则无法获取共享状态
    // int counter = JPDataWidget.of(context).counter;

    // 使用 JPDataWidget 作为 父Widget，
    // 包裹的 子Widget 可以通过 JPDataWidget.of(context) 去获取 JPDataWidget 的共享状态
    return JPDataWidget(
      counter: counter, // 自定义共享状态值，可修改
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _JPDemo1(),
            _JPDemo2(),
            _JPDemo3()
          ],
        ),
      ),
    );
  }
}

class _JPDemo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: JPRandomColor(),
      child: Text("${JPDataWidget.of(context).counter}", style: TextStyle(fontSize: 30, color: JPRandomColor())),
    );
  }
}

class _JPDemo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int counter = JPDataWidget.of(context).counter;

    return Card(
      color: JPRandomColor(),
      child: Text("$counter", style: TextStyle(fontSize: 30, color: JPRandomColor())),
    );
  }
}

class _JPDemo3 extends StatefulWidget {
  @override
  __JPDemo3State createState() => __JPDemo3State();
}

class __JPDemo3State extends State<_JPDemo3> {
  
  // 触发情况一：调用 initState 调用
  // 触发情况二：从其他对象中依赖一些数据发生改变时，比如 InheritedWidget
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    JPrint("JPDemo3 执行 State 的 didChangeDependencies 方法");
  }

  @override
  Widget build(BuildContext context) {
    int counter = JPDataWidget.of(context).counter;

    return Card(
      color: JPRandomColor(),
      child: Text("$counter", style: TextStyle(fontSize: 30, color: JPRandomColor())),
    );
  }
}
