import 'base_meal_view_model.dart';
import 'package:excellent_cuisine/core/model/meal_model.dart';

class JPFavorViewModel extends JPBaseMealViewModel {
  
  void addMeal(JPMealModel meal) {
    originMeals.add(meal);
    notifyListeners(); // 通知所有监听者
  }

  void removeMeal(JPMealModel meal) {
    originMeals.remove(meal);
    notifyListeners(); // 通知所有监听者
  }

  bool isFavor(JPMealModel meal) => originMeals.contains(meal);

  void favorHandle(JPMealModel meal) {
    if (originMeals.contains(meal)) {
      removeMeal(meal);
    } else {
      addMeal(meal);
    }
  }
}