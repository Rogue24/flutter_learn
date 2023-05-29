import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/douban/main/initialize_items.dart';
import 'package:jp_flutter_demo/JPLog.dart';

class DoubanApp extends StatelessWidget {
  static const String routeName = "/douban";

  static String title = "豆瓣";

  @override
  Widget build(BuildContext context) {
    // 获取路由参数
    var settings = ModalRoute.of(context)?.settings;
    var name = settings?.name;
    var arguments = settings?.arguments;
    if (name != null) JPrint("settings.name --- $name");
    if (arguments != null) JPrint("settings.arguments --- $arguments");

    return MaterialApp(
      // 标题
      title: DoubanApp.title,
      
      // 主题色
      theme: ThemeData(
        primarySwatch: Colors.green,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent // 默认高亮时会有个波纹（安卓那种），设置颜色透明移除这个波纹
      ),

      // 内容
      home: JPMainPage(context)
      
    );
  }
}

class JPMainPage extends StatefulWidget {
  final BuildContext superCtx;

  JPMainPage(this.superCtx);

  @override
  _JPMainPageState createState() => _JPMainPageState();
}

class _JPMainPageState extends State<JPMainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),

      // 底部barItem
      bottomNavigationBar: BottomNavigationBar(
        // 默认选中字体会变大，设置成跟未选中的字体一样大即可
        selectedFontSize: 12,
        unselectedFontSize: 12,

        // 默认当item超过4个，文本会隐藏，想显示文本得设置这个属性为fixed
        type: BottomNavigationBarType.fixed,
        items: items,

        // 刷新选中下标
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            JPrint("点了第$index个");
            _currentIndex = index;
          });
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () => Navigator.of(widget.superCtx).pop("goodbye douban"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}
