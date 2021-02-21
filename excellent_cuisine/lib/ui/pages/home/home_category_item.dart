import 'package:flutter/material.dart';

import 'package:excellent_cuisine/JPLog.dart';
import 'package:excellent_cuisine/core/model/category_model.dart';
import 'package:excellent_cuisine/ui/extension/int_extension.dart';
import 'package:excellent_cuisine/ui/shared/JPAppTheme.dart';
import 'package:excellent_cuisine/ui/pages/meal/meal_screen.dart';

class JPHomeCategoryItem extends StatelessWidget {
  final double itemRadius = 12.px;
  final double fontSize = JPAppTheme.normalFontSize;
  final FontWeight fontWeight = FontWeight.bold;

  final JPCategoryModel _category;
  JPHomeCategoryItem(this._category);  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(JPMealScreen.routeName, arguments: _category),
      
      child: Container(
        // color: JPRandomColor(),
        // 设置了decoration就不能设置color，互相冲突
        decoration: BoxDecoration(
          // 圆角
          borderRadius: BorderRadius.circular(itemRadius),
          // LinearGradient：线性渐变
          gradient: LinearGradient(
            colors: [
              _category.kColor.withOpacity(0.6),
              _category.kColor
            ],
          )
        ),
        
        child: Center(
          child: Text(
            _category.title, 
            style: TextStyle(
              color: JPRandomColor(), 
              fontWeight: fontWeight,
              fontSize: fontSize, 
            )
          ),
        ),
      ),
    );
  }
}