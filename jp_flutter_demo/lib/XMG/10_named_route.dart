import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'package:jp_flutter_demo/demo/product_list.dart';
import 'package:jp_flutter_demo/demo/random_words.dart';
import 'package:jp_flutter_demo/douban/main/douban.dart';
import 'package:jp_flutter_demo/XMG/9_MaterialPageRoute.dart';

/* 学自：https://juejin.cn/post/6844903527970504712 */

class NamedRouteExample extends StatefulWidget {
  static String title = "路由导航 命名路由";

  @override
  _NamedRouteExampleState createState() => _NamedRouteExampleState();
}

class _NamedRouteExampleState extends State<NamedRouteExample> {
  String _message = NamedRouteExample.title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          NamedRouteExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_message, style: TextStyle(fontSize: 20, color: JPRandomColor()), textAlign: TextAlign.center,),

            RaisedButton(
              child: Text("push to the douban in routes"),
              onPressed: () => pushToDemo(context, DoubanApp.routeName, arguments: "NamedRoute message: hello~"),
            ),
            RaisedButton(
              child: Text("push to the product list in routes"),
              onPressed: () => pushToDemo(context, ProductList.routeName, arguments: "NamedRoute message: hi~"),
            ),
            RaisedButton(
              child: Text("push to the random words in routes"),
              onPressed: () => pushToDemo(context, RandomWords.routeName, arguments: "NamedRoute message: hey~"),
            ),
            RaisedButton(
              child: Text("push to the test page demo by GenerateRoute"),
              onPressed: () => pushToDemo(context, TestPageDemo.routeName, arguments: "come from NamedRouteExample"),
            ),
            RaisedButton(
              child: Text("push to the unknown page for UnknownRoute"),
              onPressed: () => pushToDemo(context, "我是不存在的", arguments: "飞蛾扑火"),
            )
          ],
        ),
      ),
      
    );
  }

  // "/douban": (ctx) => DoubanApp(),
  // "/product_list": (ctx) => ProductList(),
  // "/random_words": (ctx) => RandomWords(),

  void pushToDemo(BuildContext context, String routeName, {String arguments}) {
    // arguments：路由参数，目标Page通过 ModalRoute.of(context).settings.arguments 获取参数。
    Navigator.of(context).pushNamed(routeName, arguments: arguments).then((value) {
      // 监听返回信息
      setState(() {
        JPrint("返回信息：$value");
        _message = "I am back,\nfrom \"$routeName\",\npop message: ${value ?? "not thing"}.";
      });
    });
  }
}