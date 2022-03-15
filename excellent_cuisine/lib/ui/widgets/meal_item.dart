import 'package:excellent_cuisine/core/view_model/favor_view_model.dart';
import 'package:flutter/material.dart';

import 'package:excellent_cuisine/core/model/meal_model.dart';
import 'package:excellent_cuisine/ui/extension/int_extension.dart';
import 'package:excellent_cuisine/ui/pages/detail/detail_screen.dart';
import 'package:provider/provider.dart';
import 'operation_item.dart';

final double _cardRadius = 12.px;

class JPMealItem extends StatelessWidget {
  final JPMealModel _meal;
  final String _whereFrom;
  JPMealItem(this._meal, this._whereFrom);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        // 跟外部其他widget的间距
        margin: EdgeInsets.all(10.px),
        // 阴影
        elevation: 5,
        // 使用圆角边框：RoundedRectangleBorder
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardRadius),
        ),

        child: Column(
          children: [
            buildInfoWidget(context),
            buildOperationWidget()
          ],
        ),
      ),

      onTap: () {
        // Navigator.of(context).pushNamed(JPDetailScreen.routeName, arguments: _meal);
        Navigator.of(context).push(
          // 只有 tag 一样的 widget 才有 Hero 动画效果，其他的使用渐变过渡（否则就是默认的 push 效果）
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              // FadeTransition：渐变过渡
              return FadeTransition(
                opacity: animation1, 
                child: JPDetailScreen(),
              );
            },
            // 参数
            settings: RouteSettings(
              name: JPDetailScreen.routeName, 
              arguments: [_meal, _whereFrom] // 使用数组形式传递多参数
            ),
            // 转场时长
            transitionDuration: Duration(milliseconds: 350), 
          ),
        );
      },
    );
  }

  Widget buildInfoWidget(BuildContext ctx) {
    return Stack(
      children: [
        Hero(
          // 要保证只有【来去】的页面的tag一样，不会跟其他页面的tag一样，否则会突然跟另一个地方的页面有过渡动画
          tag: "${_whereFrom}_${_meal.imageUrl}",

          // ClipRRect：专门对 子Widget（child）进行裁剪
          child: ClipRRect( 
            // 对 child 的左上和右上角进行圆角裁剪
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_cardRadius),
              topRight: Radius.circular(_cardRadius)
            ),

            child: Container(
              color: Colors.black12,
              child: Image.network(
                _meal.imageUrl,
                width: double.infinity, // 宽度尽可能延伸（填满）
                height: 250.px,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        Positioned(
          // 右下角贴边
          right: 0,
          bottom: 0,

          child: Container(
            // padding：跟 child 的内间距
            padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 5.px),
            // decoration：样式（设置了 decoration 就不能设置 color，只能通过 decoration.color 设置）
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.px)),
            ),
            // child：内容
            child: Text(
              _meal.title, 
              style: Theme.of(ctx).textTheme.headline3?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),

      ],
    );
  }

  Widget buildOperationWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.px, horizontal: 16.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          JPOperationItem(Icon(Icons.schedule), "${_meal.duration}分钟"),
          JPOperationItem(Icon(Icons.restaurant), _meal.complexityStr),
          buildFavorItem(),
        ],
      ),
    );
  }

  Widget buildFavorItem() {
    return Consumer<JPFavorViewModel>(
      builder: (ctx, favorVM, child) {
        // 判断是否已收藏
        bool isFavor = favorVM.isFavor(_meal);
        var icon = isFavor ? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_border);
        var title = isFavor ? "已收藏" : "收藏";
        var titleColor = isFavor ? Colors.red : Colors.black;
        return GestureDetector(
          child: JPOperationItem(icon, title, titleColor: titleColor),
          onTap: () => favorVM.favorHandle(_meal),
        );
      },
    );
  }
}