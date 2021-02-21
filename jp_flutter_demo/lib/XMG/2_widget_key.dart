import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844904170571431944 */

class WidgetKeyExample extends StatelessWidget {
  static String title = "Widget-key";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          WidgetKeyExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: Colors.lightGreen,

      body: _WidgetKeyDemo()
    );
  }
}

class _WidgetKeyDemo extends StatefulWidget {
  @override
  _WidgetKeyDemoState createState() => _WidgetKeyDemoState();
}

class _WidgetKeyDemoState extends State<_WidgetKeyDemo> {
  final List<String> names = ["111", "222", "333"];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 20,
          top: 20,
          child: Container(
            child: Center(child: Text("我喜欢你", style: TextStyle(fontSize: 20, color: JPRandomColor()))), 
            width: 200, 
            height: 200, 
            color: JPRandomColor()
          ),
        ),
        
        ListView(
          children: names.map((item) {
            // 1.每删除一次，全部都会重建
            // return _LisetItemLess(item); 

            // 2.没有key，靠前的才保留
            // return _LisetItemFul(item); 

            // 3.固定key（LocalKey），能准确删除
            return _LisetItemFul(item, key: ValueKey(item)); // ValueKey 是 LocalKey 的子类

            // 4.UniqueKey：保证每次生成的key都不一样，是唯一的，对比肯定都是false，全部都会重建 ==> 这样可以强制刷新 StatefulWidget，不复用
            // return _LisetItemFul(item, key: UniqueKey()); 
          }).toList(),
        ),

        Positioned(
          right: 20,
          bottom: 80,
          child: FloatingActionButton(
            child: Icon(Icons.delete),
            onPressed: () => setState(() => names.removeAt(0)), // 点击删除第1个元素
          ),
        ),
      ],
    );
  }
}

/*
 *【案例】：点击按钮删除第1个元素，查看 Element tree 的变化
 * PS1：每个 Widget 都是用的随机背景色，如果重建了，背景色会不一样，一样说明没有被重建
 * PS2：只要有删除或改变，Widget tree 肯定都会全部重建，关键是看 Element tree 的变化
 * 
 * 一：使用的是 StatelessWidget，删除第1个元素后，剩下的 Widget 会变色
 * StatelessWidget 只能展示，不能改变，因此只要有删除或改变，Element tree 都会全部重建。
 * 
 * 二：使用的是 StatefulWidget，删除第1个元素后，数据正确刷新，前两个 Widget 没有变色，反而是把最后那个 Widget 被删掉了
 * 因为更新渲染时，Widget tree 会全部重建，每个 Element 会调用 Widget 的这个函数对比新旧Widget：
    // <<如果返回true，说明对应位置的 Element 不需要重建，只需要更新>>
    static bool canUpdate(Widget oldWidget, Widget newWidget) {
      // runtimeType：对象类型，判断旧的 Widget 和新的 Widget 是不是同一个类
      return oldWidget.runtimeType == newWidget.runtimeType && oldWidget.key == newWidget.key;
    }
 * 删掉第1个后，【前两个】Element 先开始比较，只比较 Widget 的 runtimeType 肯定返回true的（此时是没有key的情况下），不需要重建，继续沿用这个state（复用）
 * 而最后一个 Element 已经没有对应的 Widget 了，所以 Element tree 就只保留前两个 Element，删除最后一个。
 * 
 *【扩展】：删除第n个元素时，删掉的也是第n个 Element 呢？--- 使用 StatefulWidget 自带的可选参数 key
 * 自定义一个 key：LisetItemFul(item, key: ValueKey(item)); // ValueKey(xxx)：泛型，返回xxx类型的key，key = xxx
 * 有了固定的 key 就可以在 canUpdate 中准确去对比了（只比较 runtimeType 肯定返回true的），从而删除对应的 Element。
 *
 *【延伸】：怎么做到每次刷新 Element tree 都全部重建？
 * 每次给一个不一样且唯一的key：LisetItemFul(item, key: UniqueKey()); // UniqueKey：生成一个不一样且唯一的key
 * 之前的因为key要不都是空要不就是一样，所以只更新不重建，现在每次刷新都搞一个不同且唯一的key，这样 canUpdate 就肯定返回false，然后去重建 Element。
 * 这样就可以强制刷新 StatefulWidget，不复用。
 */
class _LisetItemFul extends StatefulWidget {
  final String name;

  // key 是父类 StatefulWidget 的可选参数，本身没有就得自定义构造方法
  _LisetItemFul(this.name, {Key key}) : super(key: key);

  @override
  _LisetItemFulState createState() => _LisetItemFulState();
}

class _LisetItemFulState extends State<_LisetItemFul> {
  // 随机不透明颜色
  final Color randColor = JPRandomColor(a: 0.9);

  @override
  void initState() {
    super.initState();
    JPrint("build StatefulWidget --- ${widget.key}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.name, style: TextStyle(fontSize: 18, color: Colors.white)),
      height: 80,
      color: randColor,
    );
  }
}


class _LisetItemLess extends StatelessWidget {
  final String name;
  // 随机不透明颜色
  final Color randColor = JPRandomColor(a: 0.9);

  _LisetItemLess(this.name) {
    JPrint("build StatelessWidget");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(name, style: TextStyle(fontSize: 18, color: Colors.white)),
      height: 80,
      color: randColor,
    );
  }
}