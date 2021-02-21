import 'package:flutter/material.dart';
import 'package:jp_flutter_module/shared/JPLog.dart';
import 'package:jp_flutter_module/extension/int_extension.dart';

class JPCenterAleatExample extends StatelessWidget {
  static const String routeName = "/center_aleat";

  static String title = "Center Aleat";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPCenterAleatExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: Container(),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.show_chart_sharp),
        onPressed: () {
          _JPCenterAleatPage.show(context: context);
        },
      ),
    );
  }
}

class _JPCenterAleatPage extends Dialog {

  static show({@required BuildContext context}) {
    showDialog(
      barrierDismissible: true, // 可否点击背景消失 
      context: context,
      builder: (BuildContext ctx) {
        return _JPCenterAleatPage();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // 要使用 Material 包裹
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          color: JPRandomColor(),
          height: 200.px,
          width: 200.px,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("你好咩？"),
              RaisedButton(
                child: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  
}
