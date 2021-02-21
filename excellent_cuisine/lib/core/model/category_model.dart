import 'package:flutter/material.dart';

class JPCategoryModel {
  String id;
  String title;
  String color;
  
  // 自定义属性
  Color kColor; // 颜色对象

  JPCategoryModel({this.id, this.title, this.color});

  JPCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    color = json['color'];

    // 1.将 color字符串 转成 十六进制的整型
    var colorInt = int.parse(color, radix: 16);
    // 2.目前color只有RGB的数值，需要将透明度加上（ARGB，0~255）才可以转成 Color 类型
    colorInt |= 0xFF000000;
    // 3.转成 Color 类型
    kColor = Color(colorInt);

    //   0x004CAF50
    // | 0xFF000000
    // -------------
    // = 0xFF4CAF50
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['color'] = this.color;
    return data;
  }

  @override
  String toString() {
    return "id: $id, title: $title, color: $color";
  }
}