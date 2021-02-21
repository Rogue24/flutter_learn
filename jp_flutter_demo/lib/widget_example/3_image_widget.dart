import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844903954514444302 */

class ImageWidgetExample extends StatelessWidget {
  static String title = "Image";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ImageWidgetExample.title),
      ),
      backgroundColor: Colors.pink,
      body: _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Column(
                children: [
                  Text("网络图片", style: TextStyle(fontSize: 15, color: Colors.white)),
                  Container(
                    child: Image.network(
                      "https://picsum.photos/30?random=0",
                      alignment: Alignment.topCenter,
                      repeat: ImageRepeat.repeat, // 当图片本身大小 < 显示空间大小时，则重复图片平铺
                      // color & colorBlendMode：在图片绘制时可以对每一个像素进行颜色混合处理
                      color: Colors.green, // 混合色
                      colorBlendMode: BlendMode.colorDodge, // 混合模式
                    ),
                    width: 180,
                    height: 180,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
              
              SizedBox(width: 10,),

              Column(
                children: [
                  Text("本地图片", style: TextStyle(fontSize: 15, color: Colors.white)),
                  Container(
                    child: Image.asset("assets/images/Dwa.jpg"), // 当不指定宽高时，图片会根据当前父容器的限制，尽可能的显示其原始大小
                    width: 180,
                    height: 180,
                    color: Colors.lightBlue,
                  ),
                ],
              )
            ],
          ),
          
          SizedBox(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              CircleAvatar(
                radius: 80, // 宽高 = radius * 2
                // NetworkImage 继承 ImageProvider，ImageProvider是一个抽象类
                backgroundImage: NetworkImage("https://picsum.photos/160?random=1"),
                // 可以在上面放其他widget（这里Container的作用是为了可以控制文字在其中的位置调整）
                child: Container(
                  alignment: Alignment(0, 0.5),
                  width: 160,
                  height: 160,
                  child: Text(
                    "圆角头像一：CircleAvatar", 
                    style: TextStyle(fontSize: 13, color: Colors.white), 
                    textAlign: TextAlign.center
                  ),
                ),
              ),
              
              SizedBox(width: 10,),

              Column(
                children: [
                  Text("圆角头像二：ClipOval", style: TextStyle(fontSize: 15, color: Colors.white)),
                  SizedBox(height: 10,),
                  // 通常是在只有头像时使用这个widget
                  ClipOval(
                    child: Image.network(
                      "https://picsum.photos/135?random=2", 
                      width: 135, 
                      height: 135, 
                      color: JPRandomColor(),
                    ),
                  )
                ],
              )
            ],

          ),

          SizedBox(height: 10,),

          Column(
            children: [
              Text("圆角图片", style: TextStyle(fontSize: 15, color: Colors.white)),
              SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg",
                  width: 160,
                  height: 160,
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }
}