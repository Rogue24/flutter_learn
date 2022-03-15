import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:excellent_cuisine/core/model/meal_model.dart';
import 'package:excellent_cuisine/ui/pages/detail/detail_content.dart';
import 'package:excellent_cuisine/ui/pages/detail/detail_favor_button.dart';

import '../../../JPLog.dart';

class JPDetailScreen extends StatelessWidget {
  static const String routeName = "/detail";

  @override
  Widget build(BuildContext context) {
    // 获取【路由】参数 --- ModalRoute.of
    var settings = ModalRoute.of(context)?.settings;
    if (settings == null) return Container(color: JPRandomColor(),);
    // JPMealModel meal = settings.arguments as JPMealModel;
    // 使用数组形式传递多参数
    var arguments = settings.arguments as List<Object>;
    JPMealModel meal = arguments[0] as JPMealModel;
    String whereFrom = arguments[1] as String;

    return Scaffold(
      appBar: AppBar(title: Text(meal.title)),
      body: JPDetailContent(meal, whereFrom),
      backgroundColor: Color.fromRGBO(250, 200, 230, 1),
      floatingActionButton: JPDetailFavorButton(meal),
    );
  }
}