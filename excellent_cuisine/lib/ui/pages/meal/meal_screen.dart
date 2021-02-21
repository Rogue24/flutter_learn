import 'package:excellent_cuisine/core/model/category_model.dart';
import 'package:flutter/material.dart';

import 'meal_content.dart';

class JPMealScreen extends StatelessWidget {
  static const String routeName = "/meal";
  
  @override
  Widget build(BuildContext context) {
    // 获取【路由】参数 --- ModalRoute.of
    var settings = ModalRoute.of(context).settings;
    JPCategoryModel category = settings.arguments as JPCategoryModel;

    return Scaffold(
      appBar: AppBar(title: Text(category.title)),
      body: JPMealContent(),
    );
  }
}