import 'http_config.dart';
import 'http_request.dart';

import 'package:excellent_cuisine/core/model/meal_model.dart';

class JPMealRequest {
  static Future<List<JPMealModel>> requestMealData() async {
    // 1.构建URL
    final mealURL = "${JPHttpConfig.baseURL}/meal";

    // 2.发送网络请求获取结果
    final result = await JPHttpRequest.request(mealURL);
    if (result == null) {
      throw Exception("The meal data is null.");
    }
    final jsonMaps = result["meal"];

    // 3.将Map转成Model
    List<JPMealModel> meals = [];
    for (var json in jsonMaps) {
      meals.add(JPMealModel.fromJson(json));
    }

    return meals;
  }
}