import 'package:flutter/material.dart';

/*
 * 此处是 Provider 使用步骤的：1.创建自己需要共享的数据
 */
class JPCounterViewModel with ChangeNotifier { // with：Mixin 混入
  int _counter = 99;

  int get counter => _counter;
  set counter(int newValue) {
    _counter = newValue;
    // 通知所有监听者
    notifyListeners();
  }
}