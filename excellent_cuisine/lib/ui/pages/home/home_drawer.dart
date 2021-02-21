import 'package:flutter/material.dart';

import 'package:excellent_cuisine/ui/shared/JPSizeFit.dart';
import 'package:excellent_cuisine/ui/extension/int_extension.dart';
import 'package:excellent_cuisine/ui/pages/filter/filter_screen.dart';

class JPHomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: JPSizeFit.screenWidth * (2.0 / 3.0),
      child: Drawer(
        child: Column(
          children: [
            buildHeaderWidget(context),
            buildListTile(Icon(Icons.restaurant), "进餐", (){
              // 关闭 Drawer（左侧菜单）需要通过【路由】关闭
              Navigator.of(context).pop();
            }),
            Divider(height: 0.5,),
            buildListTile(Icon(Icons.settings), "过滤", (){
              // 从下而上弹出
              Navigator.of(context).pushNamed(JPFilterScreen.routeName);
            }),
            Divider(height: 0.5,),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderWidget(BuildContext ctx) {
    return Container(
      color: Theme.of(ctx).accentColor,
      width: double.infinity,
      height: JPSizeFit.safeTopMargin + 51.px,
      alignment: Alignment(0, 0.75),
      child: Text(
        "开始吃", 
        style: Theme.of(ctx).textTheme.headline3.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildListTile(Widget icon, String title, Function tapHandle) {
    return ListTile(
      leading: icon,
      title: Text(title, style: TextStyle(fontSize: 16, color: Colors.black54)),
      onTap: tapHandle,
    );
  }
}