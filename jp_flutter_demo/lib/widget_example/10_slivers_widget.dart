import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844903957739864078 */

class SliversWidgetExample extends StatelessWidget {
  static String title = "10.Slivers";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // _SliversDemo 中使用了 SliverAppBar，则不需要设置 Scaffold.appBar 了
      // appBar: AppBar(
      //   title: Text(
      //     SliversWidgetExample.title,
      //     textAlign: TextAlign.center,
      //     maxLines: 2,
      //   ),
      // ),

      backgroundColor: JPRandomColor(),

      // 切换Widget看demo
      // body: _BaseSlivers()
      body: _SliversDemo()

    );
  }
}

/*
 * Sliver 的类型：
 * SliverList：类似于我们之前使用过的 ListView；
 * SliverFixedExtentList：类似于 SliverList，只是可以设置滚动的高度；
 * SliverGrid：类似于我们之前使用过的 GridView；
 * SliverPadding：设置 Sliver 的内边距，因为可能要单独给 Sliver 设置内边距；
 * SliverAppBar：添加一个 AppBar，通常用来作为 CustomScrollView 的 HeaderView；
 * SliverSafeArea：设置内容显示在安全区域（比如不让齐刘海挡住我们的内容）
 */

class _SliversDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(SliversWidgetExample.title),
            background: Image(
              image: NetworkImage("https://tva1.sinaimg.cn/large/006y8mN6gy1g72imm9u5zj30u00k0adf.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, // 交叉轴的 item 最大宽度
            mainAxisSpacing: 10, // 主轴的间距
            crossAxisSpacing: 10, // 交叉轴的间距
            childAspectRatio: 4 // 子 Widget 的宽高比
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) { 
              print("显示时才创建 --- Gird $index");
              return Container(
                color: Colors.teal[100 * (index % 9)], // 茶色（百分比）
                alignment: Alignment.center,
                child: Text("第${index + 1}个", style: TextStyle(color: Colors.white),),
              );
            },
            childCount: 10,
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 50,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) { 
              print("显示时才创建 --- List $index");
              return Container(
                color: Colors.lightBlue[100 * (index % 9)], // 茶色（百分比）
                alignment: Alignment.center,
                child: Text("第${index + 1}个", style: TextStyle(color: Colors.white),),
              );
            },
            childCount: 50,
          ),
        )
      ],
    );
  }
}

class _BaseSlivers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverSafeArea(
          sliver: SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // 交叉轴的 item 个数
                mainAxisSpacing: 10, // 主轴的间距
                crossAxisSpacing: 5, // 交叉轴的间距
                childAspectRatio: 1 // 子 Widget 的宽高比
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) { 
                  print("显示时才创建 --- $index");
                  return Container(
                    color: Colors.brown,
                    alignment: Alignment(-1, 1),
                    child: Text("第${index + 1}个", style: TextStyle(color: Colors.white),),
                  );
                }
              ),
            ),
          ),
        )
      ],
    );
  }
}