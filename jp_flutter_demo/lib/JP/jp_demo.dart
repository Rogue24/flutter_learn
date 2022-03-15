import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JP/4_future_wait_test.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import '10_fijkplayer_test.dart';
import '11_vlcplayer_test.dart';
import '1_bottom_sheet.dart';
import '2_center_aleat.dart';
import '3_getx_test.dart';
import '5_animate_test.dart';
import '6_frame_test.dart';
import '7_swiper_test.dart';
import '8_NestedScrollView_test.dart';
import '9_nullSafety_test.dart';

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

        Divider(),
        ListTile(
          title: Text(
            JPGetxExample.title,
            style: _biggerFont,
          ),
          onTap: () => JPPush(widget: JPGetxExample(), context: context),
        ),

        Divider(),
        ListTile(
          title: Text(
            JPFutureWaitExample.title,
            style: _biggerFont,
          ),
          onTap: () => JPPush(widget: JPFutureWaitExample(), context: context),
        ),

        Divider(),
        ListTile(
          title: Text(
            JPAnimateExample.title,
            style: _biggerFont,
          ),
          onTap: () => JPPush(widget: JPAnimateExample(), context: context),
        ),

        Divider(),
        ListTile(
          title: Text(
            JPFrameExample.title,
            style: _biggerFont,
          ),
          onTap: () => JPPush(widget: JPFrameExample(), context: context),
        ),

        Divider(),
        ListTile(
          title: Text(
            JPSwiperExample.title,
            style: _biggerFont,
          ),
          onTap: () => JPPush(widget: JPSwiperExample(), context: context),
        ),

        Divider(),
        ListTile(
          title: Text(
            JPNestedScrollViewExample.title,
            style: _biggerFont,
          ),
          onTap: () => JPPush(widget: JPNestedScrollViewExample(), context: context),
        ),

        Divider(),
        ListTile(
          title: Text(
            JPNullSafetyTestViewExample.title,
            style: _biggerFont,
          ),
          onTap: () => JPPush(widget: JPNullSafetyTestViewExample(), context: context),
        ),

        Divider(),
        ListTile(
          title: Text(
            JPFijkplayerTestViewExample.title,
            style: _biggerFont,
          ),
          onTap: () => JPPush(widget: JPFijkplayerTestViewExample(), context: context),
        ),

        Divider(),
        ListTile(
          title: Text(
            JPVlcplayerTestViewExample.title,
            style: _biggerFont,
          ),
          onTap: () => JPPush(widget: JPVlcplayerTestViewExample(), context: context),
        ),
      ],
    );
  }
}