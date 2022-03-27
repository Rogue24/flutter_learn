import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SidebarItem {
  String title;
  LinearGradient background;
  Icon icon;

  SidebarItem(this.title, this.background, this.icon);
}

var sidebarItems = [
  SidebarItem(
    "Home", 
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF00AEFF),
        Color(0XFF0076FF),
      ],
    ), 
    Icon(
      Icons.home, 
      color: Colors.white,
    )
  ),

  SidebarItem(
    "Courses", 
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFA7d75),
        Color(0XFFC23D61),
      ],
    ), 
    Icon(
      Platform.isIOS ? CupertinoIcons.book_solid : Icons.library_books, 
      color: Colors.white,
    )
  ),

  SidebarItem(
    "Billing", 
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFAD64A),
        Color(0XFFEA880F),
      ],
    ), 
    Icon(
      Icons.credit_card, 
      color: Colors.white,
    )
  ),

  SidebarItem(
    "Settings", 
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF4E62CC),
        Color(0XFF202A78),
      ],
    ), 
    Icon(
      Platform.isIOS ? CupertinoIcons.settings_solid : Icons.settings, 
      color: Colors.white,
    )
  ),
];