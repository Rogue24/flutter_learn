
import 'package:flutter/material.dart';
import 'package:jp_flutter_module/pages/JP/jp_demo.dart';
import 'package:jp_flutter_module/pages/JP/1_bottom_sheet.dart';
import 'package:jp_flutter_module/pages/JP/2_center_aleat.dart';
import 'package:jp_flutter_module/pages/JP/jp_main.dart';
import 'unknown.dart';

class JPRoute {
  static final Map<String, WidgetBuilder> routes = {
    JPMainPage.routeName: (ctx) => JPMainPage(),
    JPDemo.routeName: (ctx) => JPDemo(),
    JPBottomSheetExample.routeName: (ctx) => JPBottomSheetExample(),
    JPCenterAleatExample.routeName: (ctx) => JPCenterAleatExample(),
  };
  
  static final RouteFactory onGenerateRoute = (settings) {
    return null;
  };

  static final RouteFactory onUnknownRoute = (settings) {
    return MaterialPageRoute(builder: (context) => JPUnknownPage(settings));
  };
}

