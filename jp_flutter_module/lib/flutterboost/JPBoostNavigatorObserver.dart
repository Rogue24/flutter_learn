import 'package:flutter/material.dart';
import '../shared/JPLog.dart';

class JPBoostNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    JPrint("JP_flutterboost_navigator_observer: didPush");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    JPrint("JP_flutterboost_navigator_observer: didPop");
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    JPrint("JP_flutterboost_navigator_observer: didRemove");
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    JPrint("JP_flutterboost_navigator_observer: didReplace");
  }
}