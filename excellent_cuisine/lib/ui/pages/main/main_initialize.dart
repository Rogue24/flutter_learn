import 'dart:core';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../favor/favor_screen.dart';

final List<Widget> mainPages = [
  JPHomeScreen(),
  JPFavorScreen()
];

final List<BottomNavigationBarItem> mainItems = [
  BottomNavigationBarItem(label: "首页", icon: Icon(Icons.home)),
  BottomNavigationBarItem(label: "收藏", icon: Icon(Icons.favorite)),
]; 