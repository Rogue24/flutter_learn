import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/model/moguBanner_model.dart';
import 'package:jp_flutter_demo/demo/json_decode.dart';

/* 学自：https://juejin.cn/post/6844903957739864078 */

class GirdWidgetExample extends StatelessWidget {
  static String title = "Gird";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          GirdWidgetExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
      backgroundColor: Colors.yellowAccent,

      // 切换Widget看demo
      // body: _BaseGrid()
      body: _DynamicGrid()
    );
  }
}

class _DynamicGrid extends StatefulWidget {
  @override
  _DynamicGridState createState() => _DynamicGridState();
}

class _DynamicGridState extends State<_DynamicGrid> {
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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.1
        ),
        itemCount: banners.length,
        itemBuilder: (BuildContext context, int index) { 
        print("显示时才创建 --- $index");
        // return ListTile(title: Text(banners[index].title),);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              banners[index].image,
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(height: 5),
            Text(banners[index].title, style: TextStyle(fontSize: 20),),
            Text("链接：${banners[index].link}", maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        );
      },
      ),
    );
  }
}

class _BaseGrid extends StatelessWidget {

  List<Widget> getGridWidgets() {
    // List.generate：List 的工厂函数，创建[参数1：数量]个[参数2：构造器]函数内返回的元素
    return List.generate(100, (int index) {
      return Container(
        color: Colors.purple,
        alignment: Alignment(0, 0),
        child: Text("item $index", style: TextStyle(fontSize: 20, color: Colors.white),),
      );
    });
  }

  /*
   * GridView 和 ListView 对比有一个特殊的参数：gridDelegate
   * gridDelegate 用于控制交叉轴的 item 数量或者宽度，需要传入的类型是 SliverGridDelegate
   * SliverGridDelegate 是一个抽象类，所以我们需要传入它的子类
   * 例如：SliverGridDelegateWithFixedCrossAxisCount 和 SliverGridDelegateWithMaxCrossAxisExtent
   * 也可以不设置 delegate，可以分别使用：GridView.count 构造函数和 GridView.extent 构造函数实现相同的效果，用法跟 ListView 差不多
   */

  @override
  Widget build(BuildContext context) {
    return GridView(
      children: getGridWidgets(),

      // 1.明确交叉轴的固定数量
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 5, // 交叉轴的 item 个数
      //   mainAxisSpacing: 10, // 主轴的间距
      //   crossAxisSpacing: 5, // 交叉轴的间距
      //   childAspectRatio: 1 // 子 Widget 的宽高比
      // ),

      // 2.限制交叉轴的最大尺寸，数量由尺寸决定（放得下就放，放不下就换行）
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 80, // 交叉轴的 item 最大宽度（满足间距的情况下，可以比这个数小，但不可以比这个数大）
        mainAxisSpacing: 10, // 主轴的间距
        crossAxisSpacing: 5, // 交叉轴的间距
        childAspectRatio: 1 // 子 Widget 的宽高比
      ),
      
    );
  }
}
