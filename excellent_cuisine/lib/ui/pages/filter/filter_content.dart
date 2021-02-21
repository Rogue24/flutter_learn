import 'package:excellent_cuisine/core/view_model/filter_view_model.dart';
import 'package:flutter/material.dart';

import 'package:excellent_cuisine/ui/extension/int_extension.dart';
import 'package:provider/provider.dart';

class JPFilterContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildHeaderWidget(context),
        Divider(height: 0.5,),
        buildListView(context),
      ],
    );
  }

  Widget buildHeaderWidget(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.all(20.px),
      alignment: Alignment.center,
      child: Text(
        "展示您的选择",
        style: Theme.of(ctx).textTheme.headline3.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildListView(BuildContext ctx) {
    // 由于使用 Column 需要里面的子Widget都有确定高度，而 ListView 在 shrinkWrap 为 false 时 高度是不确定的（无限大），因此会报错，所以对 ListView 包裹一层 Expanded 占据剩余高度，让 ListView 有了明确高度。
    // Expanded：不需要设置固定的宽度，会占据剩余的部分
    return Expanded(
      child: Consumer<JPFilterViewModel>(
        builder: (ctx, filterVM, child) {
          // 都是固定的选项，使用默认方式直接生成固定好的子Widget
          return ListView(
            children: [
              buildListTile("无谷蛋白", "展示无谷蛋白食物", filterVM.isGlutenFree, (value) {
                filterVM.isGlutenFree = value;
              }),
              buildListTile("不含乳糖", "展示不含乳糖食物", filterVM.isLactoseFree, (value) {
                filterVM.isLactoseFree = value;
              }),
              buildListTile("普通素食者", "展示普通素食相关食物", filterVM.isVegetarian, (value) {
                filterVM.isVegetarian = value;
              }),
              buildListTile("严格素食者", "展示严格素食相关食物", filterVM.isVegan, (value) {
                filterVM.isVegan = value;
              }),
            ],
          );
        },
      ),
    );
  }

  Widget buildListTile(String title, String subTitle, bool value, Function onChange) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      trailing: Switch(value: value, onChanged: onChange,),
    );
  }
}