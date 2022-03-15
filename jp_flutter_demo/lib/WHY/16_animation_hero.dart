import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844904176321839118 */

class AnimationHeroExample extends StatelessWidget {
  static String title = "16.动画 Hero";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AnimationHeroExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: Padding(
        padding: EdgeInsets.all(5),
        child: GridView(
          children: getGridWidgets(context),
          // 明确交叉轴的固定数量
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 交叉轴的 item 个数
            mainAxisSpacing: 5, // 主轴的间距
            crossAxisSpacing: 5, // 交叉轴的间距
            childAspectRatio: 16 / 9 // 子 Widget 的宽高比
          ),
        ),
      ),
      
    );
  }

  /*
   * 通过动画实现两个 Page 之间的过渡，这种跨页面共享的动画被称之为享元动画（Shared Element Transition）
   * 在 Flutter 中，有一个专门的 Widget 可以来实现这种动画效果：Hero
   * 
   * Hero 可以通过 Navigator 实现从起点到终点的大小和位置的缩放位移动画，作用于被 Hero 包裹的 widget
   * 实现 Hero 动画，需要如下步骤：
   *   1.在第一个 Page1 中，定义一个起始的 Hero Widget，被称之为 source hero，并且绑定一个 tag；
   *   2.在第二个 Page2 中，定义一个终点的 Hero Widget，被称之为 destination hero，并且绑定相同的 tag；
   *   3.可以通过 Navigator 来实现第一个页面 Page1 到第二个页面 Page2 的跳转过程；
   * 
   * Flutter 会设置 Tween 来界定 Hero 从起点到终点的大小和位置，并且在图层上执行动画效果。
   */

  List<Widget> getGridWidgets(BuildContext context) {
    // List.generate：List 的工厂函数，创建[参数1：数量]个[参数2：构造器]函数内返回的元素
    return List.generate(50, (int index) {
      final String imageURL = "https://picsum.photos/400/200?random=$index";

      // 给 Image 添加一个点击手势，点击弹出大图
      return GestureDetector(

        // 使用 Hero 包裹住 <<起始Widget>>
        //【注意】：想哪个 widget 有动画才用 Hero 包裹住那个
        child: Hero(
          tag: imageURL, // 要跟 终点Hero 的 tag 保持一致且唯一，用于界定 Hero 从起点到终点的大小和位置
          child: Image.network(imageURL, fit: BoxFit.cover),
        ),

        onTap: () {
          Navigator.of(context).push(
            // 只有 tag 一样的 widget 才有缩放位移的动画效果，其他的使用渐变过渡（否则就是默认的 push 效果）
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) {
                return FadeTransition(
                  opacity: animation1, 
                  child: _ImageDetailPage(imageURL),
                );
              } 
            )
          );
        },
      );

    });
  }
}

class _ImageDetailPage extends StatelessWidget {
  final String _imageURL;

  _ImageDetailPage(this._imageURL);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JPRandomColor(),

      body: Center(

        // 给 Image 添加一个点击手势，点击返回
        child: GestureDetector(
          // 使用 Hero 包裹住 <<终点Widget>>
          //【注意】：想哪个 widget 有动画才用 Hero 包裹住那个，如果包裹的是 Center，那么起始尺寸是整个Page的大小
          child: Hero(
            tag: _imageURL, // 要跟 起始Hero 的 tag 保持一致且唯一，用于界定 Hero 从起点到终点的大小和位置
            child: Image.network(_imageURL),
          ),

          onTap: () => Navigator.of(context).pop(),
        ),

      )

    );
  }
}