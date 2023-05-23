import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'package:jp_flutter_demo/providers/navigator_provider.dart';

class JPNavigatorProviderExample extends StatelessWidget {
  static String title = "13.NavigatorProvider Example";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPNavigatorProviderExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: Container(),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.forward),
        onPressed: () {
          JPPush(widget: _JPNavigatorProviderDemo(), context: NavigatorProvider.navigatorContext!);
        },
      ),

    );
  }
}

class _JPNavigatorProviderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "JPNavigatorProviderDemo",
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: Container(),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.back_hand),
        onPressed: () {
          JPPop(context: NavigatorProvider.navigatorContext!);
        },
      ),
    );
  }
}