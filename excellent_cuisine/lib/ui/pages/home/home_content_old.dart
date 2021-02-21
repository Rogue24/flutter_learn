import 'package:flutter/material.dart';

import 'package:excellent_cuisine/JPLog.dart';
import 'package:excellent_cuisine/core/services/json_parse.dart';
import 'package:excellent_cuisine/core/model/category_model.dart';
import 'package:excellent_cuisine/ui/extension/int_extension.dart';
import 'home_category_item.dart';

// ignore: camel_case_types
class JPHomeContent_Old extends StatefulWidget {
  @override
  _JPHomeContentState createState() => _JPHomeContentState();
}

class _JPHomeContentState extends State<JPHomeContent_Old> {
  List<JPCategoryModel> _categories = [];
  
  @override
  void initState() {
    super.initState();

    // 加载数据（本地、异步）
    // ignore: unnecessary_statements
    JPJsonParse.loadCategoryData().then((categories) {
      setState(() {
        JPrint(categories);
        _categories = categories;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10.px),

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 交叉轴的 item 个数
        mainAxisSpacing: 10.px, // 主轴的间距
        crossAxisSpacing: 10.px, // 交叉轴的间距
        childAspectRatio: 1.5 // 子 Widget 的宽高比
      ),

      itemCount: _categories.length,

      itemBuilder: (ctx, i) {
        JPCategoryModel category = _categories[i];
        return JPHomeCategoryItem(category);
      },
    );
  }
}