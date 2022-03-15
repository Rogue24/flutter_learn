import 'package:excellent_cuisine/JPLog.dart';
import 'package:excellent_cuisine/core/model/category_model.dart';
import 'package:excellent_cuisine/core/model/meal_model.dart';
import 'package:excellent_cuisine/core/view_model/meal_view_model.dart';
import 'package:excellent_cuisine/ui/widgets/meal_item.dart';
import 'package:excellent_cuisine/ui/extension/int_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JPMealContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1.获取【路由】参数 --- ModalRoute.of
    var settings = ModalRoute.of(context)?.settings;
    if (settings == null) return Container(color: JPRandomColor(),);

    JPCategoryModel category = settings.arguments as JPCategoryModel;

    // 2.使用 Selector 进行映射并过滤：从所有菜式（JPMealViewModel.meals）中筛选出属于当前分类（category.id）的菜式
    // PS：这里会是首次访问到JPMealViewModel的地方
    return Selector<JPMealViewModel, List<JPMealModel>>(
      // selector 用于类型转换，把 A -> S 的操作丢在函数里面，如果不需要转换直接返回 S
      // 类似 Swift 的 map 函数
      selector: (ctx, mealVM) {
        // 映射并过滤：JPMealViewModel --> List<JPMealModel>
        return mealVM.meals.where((meal) => meal.categories.contains(category.id)).toList();
      },

      // 是否需要重新构建（返回true，Selector.builder 会重新build，返回 false 则不重建）
      // 参数都是经过 selector 返回后的对象
      shouldRebuild: (oldMeals, newMeals) {
        // 新旧两个列表长度或元素不一样时才重新build
        return !listEquals(oldMeals, newMeals);
      },

      builder: (ctx, meals, child) {
        if (meals.length == 0) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.no_food),
                SizedBox(height: 8.px,),
                Text("暂无菜式")
              ],
            ),
          ); 
        }
        return ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, i) => JPMealItem(meals[i], "mealContent"),
        );
      },
      
    );

    // 使用 Consumer 的话，当共享数据发生变化就会随着变化（重新执行builder）
    // return Consumer<JPMealViewModel>(
    //   builder: (ctx, mealVM, child) {
    //     JPrint("过滤前 --- ${mealVM.meals.length}");
    //     List<JPMealModel> meals = mealVM.meals.where((meal) {
    //       return meal.categories.contains(category.id);
    //     }).toList();
    //     JPrint("过滤后 --- ${meals.length}");
    //     return Container();
    //   },
    // );
  }
}
