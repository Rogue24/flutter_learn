import 'package:flutter/material.dart';

import 'package:excellent_cuisine/ui/shared/JPSizeFit.dart';
import 'package:excellent_cuisine/core/model/meal_model.dart';
import 'package:excellent_cuisine/ui/extension/int_extension.dart';
import 'package:excellent_cuisine/ui/extension/double_extension.dart';

class JPDetailContent extends StatelessWidget {
  // 使用传递方式获取JPMealModel，因为此文件有多处地方会用到该对象，如果都通过路由获取就比较繁琐了。
  final JPMealModel _meal;
  final String _whereFrom;
  JPDetailContent(this._meal, this._whereFrom);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: JPSizeFit.safeBottomMargin + 10.px),
      child: Column(
        children: [
          // 1.横幅图片
          buildBannerImage(),
          // 2.制作材料列表
          buildTitle(context, "制作材料"),
          buildMakeMaterialList(),
          // 3.制作步骤列表
          buildTitle(context, "步骤"),
          buildMakeStepsList(),
        ],
      ),
    );
  }
}

extension BuildSubWidgets on JPDetailContent {
  // 1.横幅图片
  Widget buildBannerImage() {
    return Hero(
      // 要保证只有【来去】的页面的tag一样，不会跟其他页面的tag一样，否则会突然跟另一个地方的页面有过渡动画
      tag: "${_whereFrom}_${_meal.imageUrl}",
      
      child: Container(
        color: Colors.black12,
        child: Image.network(
          _meal.imageUrl,
          width: double.infinity, // 宽度尽可能延伸（填满）
          height: (250.0 * (375.0 / 355.0)).px,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 2.制作材料列表
  Widget buildMakeMaterialList() {
    return buildBorderContainer(
      bgColor: Colors.lightBlue,
      borderColor: Colors.grey,

      child: ListView.builder(
        // 是否全包裹 --- true：内容有多高ListView就有多高（包裹内容）；false：只延伸至父组件的高度
        shrinkWrap: true, 
        // 设置滚动机制 --- NeverScrollableScrollPhysics：永不滚动
        physics: NeverScrollableScrollPhysics(),
        // 设置内边距（默认底部会突出一些）
        padding: EdgeInsets.zero,

        itemCount: _meal.ingredients.length,
        itemBuilder: (ctx, i) {
          return Card(
            color: Colors.white,
            // margin: EdgeInsets.zero, // 默认周围就会有一点外间距
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.px, horizontal: 10.px),
              child: Text(_meal.ingredients[i]),
            ),
          );
        },
      )
    );
  }

  // 3.制作步骤列表
  Widget buildMakeStepsList() {
    return buildBorderContainer(
      child: ListView.separated(
        // 是否全包裹 --- true：内容有多高ListView就有多高（包裹内容）；false：只延伸至父组件的高度
        shrinkWrap: true, 
        // 设置滚动机制 --- NeverScrollableScrollPhysics：永不滚动
        physics: NeverScrollableScrollPhysics(),
        // 设置内边距（默认底部会突出一些）
        padding: EdgeInsets.zero,

        // 分隔线
        separatorBuilder: (ctx, i) => Divider(),

        itemCount: _meal.steps.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black87,
              child: Text("#${i + 1}"),
            ),
            title: Text(_meal.steps[i]),
          );
        },
      ),
    );
  }

  // --------------- 公共组件 ---------------

  // 标题
  Widget buildTitle(BuildContext ctx, String title) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 12.px), // 上下的间距
      child: Text(
        title, 
        style: Theme.of(ctx).textTheme.headline3?.copyWith(
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget buildBorderContainer({required Widget child, Color bgColor = Colors.white54, Color borderColor = Colors.grey}) {
    return Container(
      width: JPSizeFit.screenWidth - 20.px,
      padding: EdgeInsets.all(8.px),
      decoration: BoxDecoration(
        color: bgColor, // 背景颜色
        border: Border.all(color: borderColor), // 设置边框
        borderRadius: BorderRadius.circular(8.px), // 边框圆角
      ),
      child: child
    );
  }
}