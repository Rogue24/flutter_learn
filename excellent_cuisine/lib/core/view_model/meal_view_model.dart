import 'package:excellent_cuisine/JPLog.dart';
import 'package:excellent_cuisine/core/services/meal_request.dart';
import 'base_meal_view_model.dart';

class JPMealViewModel extends JPBaseMealViewModel {

  JPMealViewModel() {
    JPrint("初始化 --- 请求MealData");
    // 初始化时就去请求数据
    // 因为这是全局共享的ViewModel，仅一份，不会初始化两个，所以可以在初始化时获取
    JPMealRequest.requestMealData().then((result) => meals = result);
  }

}