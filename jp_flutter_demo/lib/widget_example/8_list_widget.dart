import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/model/moguBanner_model.dart';
import 'package:jp_flutter_demo/demo/json_decode.dart';

/* 学自：https://juejin.cn/post/6844903957739864078 */

class ListWidgetExample extends StatelessWidget {
  static String title = "8.List";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ListWidgetExample.title, textAlign: TextAlign.center, maxLines: 2,),
      ),

      backgroundColor: Colors.blueGrey,

      // 切换Widget看demo
      // body: _BaseList()
      // body: _DirectionList()
      // body: _BuilderList()
      body: _DynamicList()
    );
  }
}

class _DynamicList extends StatefulWidget {
  @override
  _DynamicListState createState() => _DynamicListState();
}

class _DynamicListState extends State<_DynamicList> {
  List<MoguBanner> banners = [];

  @override
  void initState() {
    print("执行 State 的 init 方法");
    super.initState();

    // 在初始化状态的方法中加载数据
    print("假装去网络请求（延时2s）");
    Future.delayed(Duration(seconds: 2), () {
      loadLocalJSON().then((banners){
        print("请求拿到数据了");
        setState(() {
          this.banners = banners + banners + banners;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final blackLine = Divider(color: Colors.black, thickness: 3); // Divider 的 height 只是所占区域的高度，并不是分隔线的高度
    final whiteLine = Divider(color: Colors.white, thickness: 3); // thickness 才是分隔线的厚度

    // ListView.separated 可以生成列表项之间的分割器，它除了比 ListView.builder 多了一个 separatorBuilder 参数
    // separatorBuilder 参数是一个分割器生成器，一定要有不能为空。
    return ListView.separated(
      // separatorBuilder 的类型跟 itemBuilder 一样，都是 IndexedWidgetBuilder，是一个函数类型。
      separatorBuilder: (BuildContext context, int index) {
        return index % 2 == 0 ? blackLine : whiteLine;
      },
      cacheExtent: 100, // 默认加载的高度、预加载高度、估算高度
      itemCount: banners.length,
      itemBuilder: (BuildContext context, int index) { 
        print("显示时才创建 --- $index");
        // return ListTile(title: Text(banners[index].title),);
        return Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                banners[index].image,
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(height: 8),
              Text(banners[index].title, style: TextStyle(fontSize: 20),),
              SizedBox(height: 5),
              Text("链接：${banners[index].link}"),
            ],
          )
        );
      },
    );
  }
}

class _BuilderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50, // 表示 item 的数量，如果为 null，则表示无限个
      itemExtent: 80,
      // itemBuilder：列表项创建的方法。
      // 当列表滚动到对应位置的时候，ListView会自动调用该方法来创建对应的子Widget。
      // 类型是IndexedWidgetBuilder，是一个函数类型。
      itemBuilder: (BuildContext context, int index) { 
        print("显示时才创建 --- $index");
        return ListTile(title: Text("第${index + 1}个"),);
      },
    );
  }
}

class _DirectionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      itemExtent: 200, // 该属性会设置【滚动方向】上每个 item 所占据的 水平=宽度 / 垂直=高度。
      children: [
        // PS：Container 要起码设置 width 或 height 其中一个，否则不能正常显示，如果宽高只设置其中一个，另一个则会设置成父组件的最大尺寸
        Container(
          color: Colors.red
        ),
        Container(
          color: Colors.green
        ),
        Container(
          color: Colors.blue
        ),
        Container(
          color: Colors.yellow
        ),
        Container(
          color: Colors.orange
        ),
      ],
    );
  }
}

class _BaseList extends StatelessWidget {
  final TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            "人的一切痛苦，本质上都是对自己无能的愤怒。",
            style: textStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            "人活在世界上，不可以有偏差；而且多少要费点劲儿，才能把自己保持到理性的轨道上。",
            style: textStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            "我活在世上，无非想要明白些道理，遇见些有趣的事。",
            style: textStyle,
          ),
        ),

        ListTile(
          leading: Icon(Icons.people, size: 36, color: Colors.white,),
          title: Text("联系人", style: TextStyle(color: Colors.white),),
          subtitle: Text("联系人信息", style: TextStyle(color: Colors.white),),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
        ),
        ListTile(
          leading: Icon(Icons.email, size: 36, color: Colors.white,),
          title: Text("邮箱", style: TextStyle(color: Colors.white),),
          subtitle: Text("邮箱地址信息", style: TextStyle(color: Colors.white),),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
        ),
        ListTile(
          leading: Icon(Icons.message, size: 36, color: Colors.white,),
          title: Text("消息", style: TextStyle(color: Colors.white),),
          subtitle: Text("消息详情信息", style: TextStyle(color: Colors.white),),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
        ),
        ListTile(
          leading: Icon(Icons.map, size: 36, color: Colors.white,),
          title: Text("地址", style: TextStyle(color: Colors.white),),
          subtitle: Text("地址详情信息", style: TextStyle(color: Colors.white),),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
        )
      ],
    );
  }
}