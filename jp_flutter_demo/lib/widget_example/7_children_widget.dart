import 'package:flutter/material.dart';

/* 学自：https://juejin.cn/post/6844903956548681735#heading-0 */

class ChildrenWidgetExample extends StatelessWidget {
  static String title = "7.Row & Column & Stack";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ChildrenWidgetExample.title, textAlign: TextAlign.center, maxLines: 2,),
      ),
      backgroundColor: Colors.yellow,

      body: Column(
        children: [
          _RowContent(),
          
          // Expanded：不需要设置固定的宽度，占据剩余的部分（上下两个组件都有固定的高度）
          Expanded(
            child: _ColumnContent(),
          ),

          _StackContent()
        ],
      ),
      
    );
  }
}

class _RowContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // spaceEvenly 将主轴空白区域均分，各个子组件间距相等
      // textDirection: TextDirection.rtl, // 如果这个设置为右到左，那么起始点从右边开始
      crossAxisAlignment: CrossAxisAlignment.end,
      // verticalDirection: VerticalDirection.up, // 垂直方向的指向方向，CrossAxisAlignment 跟随着这个属性而变化
      mainAxisSize: MainAxisSize.min,
      children: [
        
        // Expanded：不需要设置固定的宽度，占据剩余的部分
        Expanded(
          flex: 1, // 例如这里为1，则剩余空间这个组件所占空间为 1 / 3
          child: Container(
            color: Colors.red, 
            height: 60,
          )
        ),
        // Container(
        //   color: Colors.red, width: 60, height: 60,
        // ),
        
        Container(
          color: Colors.green, width: 80, height: 80,
        ),

        Container(
          color: Colors.blue, width: 70, height: 70,
        ),

        Expanded(
          // flex：弹性系数，Row会根据两个Expanded的弹性系数来决定它们占据剩下空间的比例
          flex: 2, // 例如这里为2，则剩余空间这个组件所占空间为 2 / 3
          child: Container(
            color: Colors.pink, 
            height: 100,
          ),
        )
        // Container(
        //   color: Colors.pink, width: 100, height: 100,
        // ),
      ],

    );
  }
}

class _ColumnContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        Expanded(
          flex: 1, // 例如这里为1，则剩余空间这个组件所占空间为 1 / 3
          child: Container(
            color: Colors.red, 
            width: 60,
          )
        ),
        
        Container(
          color: Colors.green, width: 80, height: 80,
        ),

        Container(
          color: Colors.blue, width: 70, height: 70,
        ),

        Expanded(
          flex: 2, // 例如这里为2，则剩余空间这个组件所占空间为 2 / 3
          child: Container(
            color: Colors.pink, 
            width: 100,
          ),
        )

      ]
    );
  }
}

// Stack：栈，用于叠加组件，children 是从底往上叠加
class _StackContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.blueAccent,
          width: 300,
          height: 300,
        ),

        // Positioned 可以决定组件在Stack中的位置，绝对定位的效果
        Positioned(
          top: 20,
          left: 20,
          child: Icon(Icons.favorite, size: 50, color: Colors.red),
        ),

        Positioned(
          bottom: 20,
          right: 20,
          child: Text("我喜欢你", style: TextStyle(fontSize: 20, color: Colors.white),),
        )
      ],
    );
  }
}