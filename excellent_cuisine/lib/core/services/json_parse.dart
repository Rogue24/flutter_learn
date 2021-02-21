import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:excellent_cuisine/JPLog.dart';
import 'package:excellent_cuisine/core/model/category_model.dart';

class JPJsonParse {
  // 异步请求 本地 JSON
  static Future<List<JPCategoryModel>> loadCategoryData({bool isThrow = false}) async {
    JPrint("延迟个3s再拿数据");
    await Future.delayed(Duration(seconds: 3));

    if (isThrow) {
      JPrint("抛出异常");
      throw "Get category data failed."; 
    }

    // 1.读取本地 json 文件
    String jsonStr = await rootBundle.loadString("assets/json/category.json");

    // 2.解析，转成 List 或 Map 类型
    final jsonResult = json.decode(jsonStr);
    final jsonMaps = jsonResult["category"];
    
    // 3.遍历并转成 MoguBanner 对象放到一个 List 中返回
    List<JPCategoryModel> categories = List();
    for (var json in jsonMaps) {
      JPCategoryModel category = JPCategoryModel.fromJson(json);
      categories.add(category);
    }
    
    JPrint("拿到数据了");
    return categories;
  }
}