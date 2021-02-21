import 'package:flutter/material.dart';
import 'bottom_bar_item.dart';
import 'package:jp_flutter_demo/douban/pages/home/home.dart';
import 'package:jp_flutter_demo/douban/pages/subject/subject.dart';
import 'package:jp_flutter_demo/douban/pages/group/group.dart';
import 'package:jp_flutter_demo/douban/pages/mall/mall.dart';
import 'package:jp_flutter_demo/douban/pages/profile/profile.dart';

List<JPBottomBarItem> items = [
  JPBottomBarItem("home", "首页"),
  JPBottomBarItem("subject", "书影音"),
  JPBottomBarItem("group", "小组"),
  JPBottomBarItem("mall", "市集"),
  JPBottomBarItem("profile", "我的")
];

List<Widget> pages = [
  JPHomePage(),
  JPSubjectPage(),
  JPGroupPage(),
  JPMallPage(),
  JPProfilePage()
];