import 'package:excellent_cuisine/core/model/category_model.dart';
import 'package:flutter/material.dart';

import 'meal_content.dart';

class JPMealScreen extends StatelessWidget {
  static const String routeName = "/meal";
  
  @override
  Widget build(BuildContext context) {
    String title = "";

    // 获取【路由】参数 --- ModalRoute.of
    var settings = ModalRoute.of(context)?.settings;
    if (settings != null) {
      JPCategoryModel category = settings.arguments as JPCategoryModel;
      title = category.title;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: JPMealContent(),
    );
  }
}