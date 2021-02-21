import 'package:flutter/material.dart';

class JPFilterViewModel extends ChangeNotifier {
  // 无谷蛋白
  bool _isGlutenFree = false;
  set isGlutenFree(bool value) {
    _isGlutenFree = value;
    notifyListeners(); // 通知所有监听者
  }
  bool get isGlutenFree => _isGlutenFree;

  // 乳糖
  bool _isLactoseFree = false;
  set isLactoseFree(bool value) {
    _isLactoseFree = value;
    notifyListeners(); // 通知所有监听者
  }
  bool get isLactoseFree => _isLactoseFree;

  // 普通素食
  bool _isVegetarian = false;
  set isVegetarian(bool value) {
    _isVegetarian = value;
    notifyListeners(); // 通知所有监听者
  }
  bool get isVegetarian => _isVegetarian;

  // 严格素食
  bool _isVegan = false;
  set isVegan(bool value) {
    _isVegan = value;
    notifyListeners(); // 通知所有监听者
  }
  bool get isVegan => _isVegan;


}