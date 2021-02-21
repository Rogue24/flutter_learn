import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:excellent_cuisine/ui/extension/int_extension.dart';
import 'package:excellent_cuisine/core/view_model/favor_view_model.dart';
import 'package:excellent_cuisine/ui/widgets/meal_item.dart';

class JPFavorContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<JPFavorViewModel>(
      builder: (ctx, favorVM, child) {
        if (favorVM.meals.length == 0) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.no_food),
                SizedBox(height: 8.px,),
                Text("暂无收藏")
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: favorVM.meals.length,
          itemBuilder: (ctx, i) => JPMealItem(favorVM.meals[i]),
        );
      },
    );
  }
}