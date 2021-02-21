import 'package:flutter/material.dart';

class JPFormViewModel with ChangeNotifier { // with：Mixin 混入
  String _phone = "15989023729";
  String _password = "abc123456";

  String get phone => _phone;
  set phone(String newValue) {
    _phone = newValue;
    // 通知所有监听者
    notifyListeners();
  }

  String get password => _password;
  set password(String newValue) {
    _password = newValue;
    // 通知所有监听者
    notifyListeners();
  }
}