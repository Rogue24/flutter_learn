import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:jp_flutter_module/shared/JPLog.dart';
import '1_bottom_sheet.dart';
import '2_center_aleat.dart';

class JPDemo extends StatelessWidget {
  static const String routeName = "/jp_demo";

  static String title = "JP Demo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(JPDemo.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            // 一般都用 result 作为参数回调，exts 一般是给到 iOS（原生）那边做一些额外处理，例如是否需要动画
            FlutterBoost.singleton.closeCurrent(result: {"jp_param": "从 jp_demo 回来的"});
          },
        ),
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
    // 路由参数
    final BoostContainerSettings settings = BoostContainer.of(context).settings;
    String subTitle = settings.params["jp_param"];

    List<Widget> _getListChildren() {
      List<Widget> children = List();

      if (subTitle != null) {
        children.add(Container(
          child: Text(subTitle, style: _biggerFont,),
          alignment: Alignment.center,
        ));
        children.add(Divider());
      }

      children.add(
        ListTile(
          title: Text(
            JPBottomSheetExample.title,
            style: _biggerFont,
          ),
          onTap: () => JPPush(widget: JPBottomSheetExample(), context: context),
        )
      );

      children.add(Divider());

      children.add(
        ListTile(
          title: Text(
            JPCenterAleatExample.title,
            style: _biggerFont,
          ),
          onTap: () => JPPush(widget: JPCenterAleatExample(), context: context),
        )
      );

      return children;
    }

    return ListView(
      children: _getListChildren(),
    );
  }
}