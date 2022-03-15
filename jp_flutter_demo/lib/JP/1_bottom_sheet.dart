import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'package:jp_flutter_demo/extension/int_extension.dart';

class JPBottomSheetExample extends StatelessWidget {
  static String title = "1.Bottom Sheet";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPBottomSheetExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: Container(),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          _JPBottomSheet.show(context: context);
        },
      ),
    );
  }
}

class _JPBottomSheet extends StatelessWidget {

  static show({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      isDismissible: true, // 可否点击背景消失 
      enableDrag: true, // 可否拖动
      builder: (BuildContext ctx) {
        return _JPBottomSheet();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: JPRandomColor(),
      height: 200.px,
    );
  }
  
}