import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844903527970504712 */

class MaterialPageRouteExample extends StatefulWidget {
  static String title = "路由导航 基本跳转";

  @override
  _MaterialPageRouteExampleState createState() => _MaterialPageRouteExampleState();
}

class _MaterialPageRouteExampleState extends State<MaterialPageRouteExample> {
  String _message = MaterialPageRouteExample.title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MaterialPageRouteExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_message, style: TextStyle(fontSize: 20, color: JPRandomColor()), textAlign: TextAlign.center),
            RaisedButton(
              child: Text("push"),
              onPressed: () => pushToDemo(context),
            ),
          ],
        ),
      ),
      
    );
  }

  void pushToDemo(BuildContext context) {
    // MaterialPageRoute 的继承链：
    // MaterialPageRoute -> PageRoute -> ModalRoute -> TransitionRoute -> OverlayRoute -> Route

    // 使用 MaterialPageRoute 将页面Widget包裹住进行跳转
    var route = MaterialPageRoute(
      builder: (context) {
        return TestPageDemo("come from MaterialPageRouteExample");
      },
    );

    // Navigator.of(context) --- 通过 context 找到 rootNavigator 对象

    // 静态方法 --- 内部其实就是调用实例方法 Navigator.of(context).push(route)
    // Navigator.push(context, route);

    // 实例方法
    Navigator.of(context).push(route).then((value) {
      // 监听返回信息
      setState(() {
        JPrint("返回信息：$value");
        _message = value ?? "not thing.";
      });
    });

  }
}








class TestPageDemo extends StatelessWidget {
  static const String routeName = "/test_page_demo";

  final String _message;

  TestPageDemo(this._message);

  @override
  Widget build(BuildContext context) {

    // 路由返回并携带信息 方法三：使用 WillPopScope，自定义导航栏返回按钮的点击事件
    // 注意：该方法会使<侧边返回手势>失效
    return WillPopScope(
      onWillPop: () {
        // 要返回一个 Future<bool> 对象
        // 返回 true：可以自动返回，Flutter会帮助我们执行返回操作
        // 返回 false：不会自动返回，需要自行编写返回代码

        Navigator.of(context).pop("I am back, from TestPageDemo_WillPopScope.");
        return Future.value(false);
      },

      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "TestPageDemo",
            textAlign: TextAlign.center,
            maxLines: 2,
          ),

          // 路由返回并携带信息 方法二：自定义导航栏返回按钮点击
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_ios),
          //   onPressed: () {
          //     Navigator.of(context).pop("I am back, from TestPageDemo_IconButton.");
          //   },
          // ),

        ),

        backgroundColor: JPRandomColor(),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_message, style: TextStyle(fontSize: 20, color: JPRandomColor())),

              // 路由返回并携带信息 方法一：自定义按钮点击
              RaisedButton(
                child: Text("pop"),
                onPressed: () => pop(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  void pop(BuildContext context) {
    Navigator.of(context).pop("I am back, from TestPageDemo_RaisedButton.");
  }
}