import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import '1_bottom_sheet.dart';
import '2_center_aleat.dart';

class JPDemo extends StatelessWidget {
  static String title = "JP Demo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(JPDemo.title),
      ),
      body: _JPDemoList(),
    );
  }
}

class _JPDemoList extends StatefulWidget {
  // 貌似使用 StatelessWidget 无法路由
  @override
  createState() => _JPDemoListState();
}

class _JPDemoListState extends State<_JPDemoList> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        
        ListTile(
          title: Text(
            JPBottomSheetExample.title,
            style: _biggerFont,
          ),
          onTap: () => JPPush(widget: JPBottomSheetExample(), context: context),
        ),

        Divider(),
        ListTile(
          title: Text(
            JPCenterAleatExample.title,
            style: _biggerFont,
          ),
          onTap: () => JPPush(widget: JPCenterAleatExample(), context: context),
        ),
      ],
    );
  }
}