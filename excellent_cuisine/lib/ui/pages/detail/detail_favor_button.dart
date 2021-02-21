import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:excellent_cuisine/core/model/meal_model.dart';
import 'package:excellent_cuisine/core/view_model/favor_view_model.dart';

class JPDetailFavorButton extends StatelessWidget {
  final JPMealModel _meal;
  JPDetailFavorButton(this._meal);
  
  @override
  Widget build(BuildContext context) {
    return Consumer<JPFavorViewModel>(
      builder: (ctx, favorVM, child) {
        // 判断是否已收藏
        bool isFavor = favorVM.isFavor(_meal);
        var icon = isFavor ? Icons.favorite : Icons.favorite_border;
        return FloatingActionButton(
          child: Icon(icon),
          onPressed: () => favorVM.favorHandle(_meal),
        );
      },
    );
  }
}