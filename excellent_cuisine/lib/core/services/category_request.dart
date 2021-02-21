import 'http_config.dart';
import 'http_request.dart';

import 'package:excellent_cuisine/core/model/category_model.dart';

class JPCategoryRequest {
  static Future<List<JPCategoryModel>> requestCategoryData() async {
    // 1.构建URL
    final categoryURL = "${JPHttpConfig.baseURL}/category";

    // 2.发送网络请求获取结果
    final result = await JPHttpRequest.request(categoryURL);
    if (result == null) {
      throw Exception("The category data is null.");
    }
    final jsonMaps = result["category"];

    // 3.将Map转成Model
    List<JPCategoryModel> categories = [];
    for (var json in jsonMaps) {
      categories.add(JPCategoryModel.fromJson(json));
    }

    return categories;
  }
}