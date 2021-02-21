import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/douban/widgets/jp_star_rating.dart';
import 'package:jp_flutter_demo/douban/widgets/jp_dashed_line.dart';

/* 学自：https://juejin.cn/post/6844903957744058381 */

class JPWidgetExample extends StatelessWidget {
  static String title = "星星打分+虚线的Widget";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPWidgetExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
      backgroundColor: Colors.indigo,

      body: JPWidgetDemo()
    );
  }
}

class JPWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100, 
            child: JPDashedLine(axis: Axis.vertical, dashedWidth: 3, dashedHeight: 7, color: Colors.green, count: 8)
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: JPStarRating(rating: 7),
          ),

          SizedBox(
            width: 200, 
            child: JPDashedLine(dashedWidth: 8, dashedHeight: 5)
          ),
        ],
      ),
    );
  }
}