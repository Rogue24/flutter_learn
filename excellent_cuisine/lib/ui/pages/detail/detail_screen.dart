import 'package:flutter/material.dart';

import 'package:excellent_cuisine/core/model/meal_model.dart';
import 'package:excellent_cuisine/ui/pages/detail/detail_content.dart';
import 'package:excellent_cuisine/ui/pages/detail/detail_favor_button.dart';

class JPDetailScreen extends StatelessWidget {
  static const String routeName = "/detail";

  @override
  Widget build(BuildContext context) {
    // 获取【路由】参数 --- ModalRoute.of
    var settings = ModalRoute.of(context).settings;
    JPMealModel meal = settings.arguments as JPMealModel;

    return Scaffold(
      appBar: AppBar(title: Text(meal.title)),
      body: JPDetailContent(meal),
      backgroundColor: Color.fromRGBO(250, 200, 230, 1),
      floatingActionButton: JPDetailFavorButton(meal),
    );
  }
}