import 'package:flutter/material.dart';

/* 学自：https://juejin.cn/post/6844903956548681735#heading-0 */

class ChildWidgetExample extends StatelessWidget {
  static String title = "Align & Center & Padding & Container";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ChildWidgetExample.title, textAlign: TextAlign.center, maxLines: 2,),
      ),
      backgroundColor: Colors.green,
      body: _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [

            Align(
              child: Icon(Icons.pets, size: 36, color: Colors.purple),
              alignment: Alignment.bottomRight, // 右下对齐
              // 宽度因子，不设置的情况，会尽可能大
              widthFactor: 3, // 这里设置为3，则水平方向以子组件3倍的宽度为最大对齐范围
              // 高度因子，不设置的情况，会尽可能大
              heightFactor: 3, // 这里设置为3，则垂直方向以子组件3倍的高度为最大对齐范围
            ),

            // Center组件继承自Align
            // 相当于是一个将 alignment 设置为 Alignment.center 的 Align
            Center(
              child: Icon(Icons.face, size: 36, color: Colors.pink),
              // 既然 Center 继承于 Align，那么这两个属性效果跟 Align 一样
              widthFactor: 3, 
              heightFactor: 3,
            ),

          ],
        ),

        Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            "床前明月光，疑是地上霜。举头望明月，低头思故乡。",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),

        Container(
          // Container 容器的大小可以通过 width、height 属性来指定，也可以通过 constraints 属性来指定
          // 如果同时存在时，width、height优先（实际上 Container 内部会根据 width、height 来生成一个 constraints）
          // Container 要起码设置 width 或 height 其中一个，否则不能正常显示，如果宽高只设置其中一个，另一个则会设置成父组件的最大尺寸
          width: 150,
          height: 150,
          child: Icon(Icons.radio, size: 50, color: Colors.red,),

          // color 和 decoration 是互斥的，这两个属性不能同时设置。
          // color: Color.fromRGBO(3, 3, 255, .5),

          // Decoration（装饰）是一个抽象类，使用它的实现类 BoxDecoration 来进行实例化
          decoration: BoxDecoration(
            color: Colors.amber,

            // 设置单边边框
            // border: Border(
            //   top: BorderSide(
            //     color: Colors.black,
            //     width: 3,
            //     style: BorderStyle.solid
            //   )
            // )
            // 设置全边框
            border: Border.all(
              color: Colors.black,
              width: 3,
              style: BorderStyle.solid
            ),

            // 设置全部圆角
            // borderRadius: BorderRadius.circular(20), 
            // 分别设置圆角
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
            ),

            // shape（形变：如切圆），跟 borderRadius 互斥，这两个属性不能同时设置。
            // shape: BoxShape.circle

            // 阴影效果
            boxShadow: [
              BoxShadow(
                offset: Offset(5, 5),
                color: Colors.purple,
                blurRadius: 5
              ),
              BoxShadow(
                offset: Offset(-5, -5),
                color: Colors.red,
                blurRadius: 5
              )
            ],

            // 渐变效果
            gradient: RadialGradient(
              colors: [
                Colors.yellow,
                Colors.blue
              ]
            )

          ),
        ),

        SizedBox(height: 10,),
        Text("使用Container实现圆角图像", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
        SizedBox(height: 5,),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: NetworkImage("https://picsum.photos/seed/picsum/200/200")
            )
          ),
        )

      ],
    );
  }
}