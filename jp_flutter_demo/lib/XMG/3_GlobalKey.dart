import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844904170571431944 */

class GlobalKeyExample extends StatelessWidget {
  static String title = "GlobalKey";

  /*
   * GlobalKey 可以访问某个 Widget 的信息
   * 例如 StatefulWidget，通过 GlobalKey 可以获取以下信息：
   * currentState：对应的state
   * currentState.widget：对应的widget（state._widget）
   * currentContext：Element，也就是 build(BuildContext context) 中的 context
   */
  final GlobalKey<__GlobalKeyDemoState> gbKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          GlobalKeyExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: _GlobalKeyDemo(gbKey),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.data_usage),
        heroTag: "1", // 如果有多个 FloatingActionButton 会导致 heroTag 的冲突，要分别设置跟其他不一样的 heroTag
        onPressed: () {
          JPrint("对应的widget（state._widget）${gbKey.currentState.widget.hashCode}");
          JPrint("对应的state ${gbKey.currentState.hashCode}");
          
          JPrint("${gbKey.currentState.widget.widgetValue}");
          JPrint("${gbKey.currentState.stateValue}");
          JPrint("${gbKey.currentContext}，也就是BuildContext");
          // 有了state对象，就可以调用state及其widget的方法
          gbKey.currentState.doSomeThing();
          gbKey.currentState.widget.doSomeThing();
        },
      )

    );
  }
}

class _GlobalKeyDemo extends StatefulWidget {
  final String widgetValue = "hi";

  // key 是父类 StatefulWidget 的可选参数，本身没有就得自定义构造方法
  _GlobalKeyDemo(Key key) : super(key: key);

  void doSomeThing() => JPrint("widget doSomeThing");

  @override
  __GlobalKeyDemoState createState() => __GlobalKeyDemoState();
}

class __GlobalKeyDemoState extends State<_GlobalKeyDemo> {
  final String stateValue = "hello";

  void doSomeThing() => JPrint("state doSomeThing");

  @override
  Widget build(BuildContext context) {
    JPrint("context ${context.hashCode}");
    JPrint("context widget ${context.widget.hashCode}");
    JPrint("当前state ${this.hashCode}");
    JPrint("当前state.widget ${this.widget.hashCode}");

    JPrint("--------------");
    
    var stulElement = context as StatefulElement;
    JPrint("context 即是 Element ${stulElement.hashCode}");
    JPrint("Element widget ${stulElement.widget.hashCode}");
    JPrint("StatefulElement state ${stulElement.state.hashCode}");
    JPrint("StatefulElement state.widget ${stulElement.state.widget.hashCode}");
    
    return Container(
      child: FloatingActionButton(
        child: Icon(Icons.beach_access),
        heroTag: "2", // 如果有多个 FloatingActionButton 会导致 heroTag 的冲突，要分别设置跟其他不一样的 heroTag
        onPressed: () {
          JPrint("$context，也就是gbKey.currentContext");
        },
      ),
    );
  }
}