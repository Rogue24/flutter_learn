import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'product_list.dart';

/* 学自：https://juejin.cn/post/6844903951058354190 */

class StatefulWidgetExample extends StatelessWidget {
  static String title = "StatefulWidget Example";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StatefulWidgetExample.title),
      ),
      body: MyCounterWidget(),
    );
  }
}

class MyCounterWidget extends StatefulWidget {
  //【1】定义到 Widget 中的数据都是不可变的，必须定义为 final
  final String abc = "aaa";

  @override
  _MyCounterWidgetState createState() => _MyCounterWidgetState();
}

class _MyCounterWidgetState extends State<MyCounterWidget> {
  //【2】不过可以在 State 里面使用变量
  int counter = 0;
  MainAxisAlignment alignment = MainAxisAlignment.center;

  // 生命周期 - 1：创建State对象
  _MyCounterWidgetState() {
    JPrint("执行 State 的 构造 方法");
  }

  // 生命周期 - 2：数据初始化
  @override
  void initState() {
    super.initState();
    JPrint("执行 State 的 init 方法");
  }

  // 生命周期 - 3
  // 触发情况一：调用initState会调用
  // 触发情况二：从其他对象中依赖一些数据发生改变时，比如InheritedWidget
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    JPrint("执行 State 的 didChangeDependencies 方法");
  }

  // 生命周期 - 4：渲染Widget
  // 调用 setState 方法，会根据最新的状态（数据）来重新调用 build 方法，构建对应的 Widgets
  @override
  Widget build(BuildContext context) {
    JPrint("执行 State 的 build 方法");

    return Center(
      child: Column(
        mainAxisAlignment: alignment,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: Colors.redAccent,
                child: Text(
                  "+1",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    JPrint("点了+1");
                    counter += 1;
                    alignment = counter == 0 ? MainAxisAlignment.center : MainAxisAlignment.start;
                  });
                },
              ),
              RaisedButton(
                color: Colors.orangeAccent,
                child: Text(
                  "-1",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    JPrint("点了-1");
                    counter -= 1;
                    alignment = counter == 0 ? MainAxisAlignment.center : MainAxisAlignment.end;
                  });
                },
              )
            ],
          ),
          Text(
            "当前计数：$counter",
            style: TextStyle(fontSize: 30),
          ),
          RaisedButton(
            child: Icon(Icons.forward),
            onPressed: () => Navigator.of(context).pushNamed(ProductList.routeName),
          ),
        ],
      ),
    );
  }

  // 当父Widget触发重建（rebuild）时，系统会调用该方法
  @override
  void didUpdateWidget(covariant MyCounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    JPrint("执行 State 的 didUpdateWidget 方法");
  }

  // 生命周期 - 5：销毁
  @override
  void dispose() {
    super.dispose();
    JPrint("执行 State 的 dispose 方法");
  }
}
