
import 'package:flutter/material.dart';
import 'package:jp_flutter_module/shared/JPLog.dart';

class JPUnknownPage extends StatelessWidget {
  final RouteSettings settings;
  
  JPUnknownPage(this.settings);

  List<Widget> getTextList() {
    List<Widget> textList = [
      Text("打开了一个不存在的路由页面", style: TextStyle(fontSize: 25, color: JPRandomColor()))
    ];
    if (settings.name != null) {
      textList.add(SizedBox(height: 8));
      textList.add(
        Text("settings.name: ${settings.name}", style: TextStyle(fontSize: 20, color: JPRandomColor()))
      );
    }
    if (settings.arguments != null) {
      textList.add(
        Text("settings.arguments: ${settings.arguments}", style: TextStyle(fontSize: 20, color: JPRandomColor()))
      );
    }
    return textList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "错误页面",
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),

        backgroundColor: JPRandomColor(),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getTextList(),
          ),
        ),
      );
  }
}