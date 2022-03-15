import 'package:flutter/material.dart';

import 'package:excellent_cuisine/core/model/meal_model.dart';
import 'package:excellent_cuisine/core/view_model/filter_view_model.dart';

class JPBaseMealViewModel extends ChangeNotifier {

  JPFilterViewModel? _filterVM;
  void filterFor(JPFilterViewModel filterVM) {
    _filterVM = filterVM;
    notifyListeners(); // 通知所有监听者
  }

  List<JPMealModel> _meals = [];
  // 赋值并通知刷新
  set meals(List<JPMealModel> value) {
    _meals = value;
    notifyListeners(); // 通知所有监听者
  }
  // 获取原始的meals
  List<JPMealModel> get originMeals => _meals;
  // 获取过滤后的meals 
  List<JPMealModel> get meals {
    return _meals.where((meal) {
      var filterVM = _filterVM;
      if (filterVM == null) return true;
      if (filterVM.isGlutenFree && !meal.isGlutenFree) return false;
      if (filterVM.isLactoseFree && !meal.isLactoseFree) return false;
      if (filterVM.isVegetarian && !meal.isVegetarian) return false;
      if (filterVM.isVegan && !meal.isVegan) return false;
      return true;
    }).toList();
  }

}