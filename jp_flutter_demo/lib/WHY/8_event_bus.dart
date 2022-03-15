import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'package:jp_flutter_demo/main.dart';
import 'package:jp_flutter_demo/model/moguBanner_model.dart';

/* 学自：https://juejin.cn/post/6844904175185166349 */

// EventBus 用于跨组件事件传递，定义在 main.dart，全局用一个即可。

class EventBusExample extends StatelessWidget {
  static String title = "8.跨组件事件传递 EventBus";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          EventBusExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: _EventBusDemo(),
      
    );
  }
}

class _EventBusDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _JPButton(),
          _JPText1(),
          _JPText2(),
          _JPText3()
        ],
      ),
    );
  }
}

class _JPButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text("发射"),
      onPressed: () {
        
        // 1.创建全局的EventBus对象 --- 定义在 main.dart，全局用一个即可

        // 2.发射事件 --- 监听方指定<发射的事件类型>即可监听到对应的事件（建议发射模型类型，不建议发射系统类如String，不然会频繁接收）
        var banner = MoguBanner(title: "111");
        eventBus.fire(banner);

        banner.title = "222";
      },
    );
  }
}

class _JPText1 extends StatefulWidget {
  @override
  __JPTextState1 createState() => __JPTextState1();
}
class __JPTextState1 extends State<_JPText1> {
  MoguBanner _banner = MoguBanner();

  @override
  void initState() {
    super.initState();

    // 3.监听事件 --- 使用泛型来指定监听哪种类型的事件
    eventBus.on<MoguBanner>().listen((event) {
      // 因为eventBus是全局的，不能销毁，所以有可能在该组件dispose之后还会接收到事件，导致错误
      // 要在使用setState()方法前判断”mounted“属性，检测该组件是否还在组件树中（是否已经被销毁）
      // 参考：https://blog.csdn.net/fwq_17802927858/article/details/101060802
      if (!mounted) return;

      setState(() {
        
        JPrint("1 --- ${event.title}");
        _banner = event;

        event.title = "333";

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_banner.title, style: TextStyle(fontSize: 20),);
  }
}

class _JPText2 extends StatefulWidget {
  @override
  __JPTextState2 createState() => __JPTextState2();
}
class __JPTextState2 extends State<_JPText2> {
  MoguBanner _banner = MoguBanner();

  @override
  void initState() {
    super.initState();

    eventBus.on<MoguBanner>().listen((event) {
      // 因为eventBus是全局的，不能销毁，所以有可能在该组件dispose之后还会接收到事件，导致错误
      // 要在使用setState()方法前判断”mounted“属性，检测该组件是否还在组件树中（是否已经被销毁）
      // 参考：https://blog.csdn.net/fwq_17802927858/article/details/101060802
      if (!mounted) return;

      setState(() {
        JPrint("2 --- ${event.title}");
        _banner = event;

        event.title = "444";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_banner.title, style: TextStyle(fontSize: 20),);
  }
}

class _JPText3 extends StatefulWidget {
  @override
  __JPTextState3 createState() => __JPTextState3();
}
class __JPTextState3 extends State<_JPText3> {
  MoguBanner _banner = MoguBanner();

  @override
  void initState() {
    super.initState();

    eventBus.on<MoguBanner>().listen((event) {
      // 因为eventBus是全局的，不能销毁，所以有可能在该组件dispose之后还会接收到事件，导致错误
      // 要在使用setState()方法前判断”mounted“属性，检测该组件是否还在组件树中（是否已经被销毁）
      // 参考：https://blog.csdn.net/fwq_17802927858/article/details/101060802
      if (!mounted) return;
      
      setState(() {
        JPrint("3 --- ${event.title}");
        _banner = event;

        event.title = "555";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_banner.title, style: TextStyle(fontSize: 20),);
  }
}

