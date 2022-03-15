import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'package:jp_flutter_demo/shared/JPAppTheme.dart';

/* 学自：https://juejin.cn/post/6844903973791465480 */

class DartThemeExample extends StatelessWidget {
  static String title = "19.Theme 适配深色模式";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 标题
      title: "App快照的标题，也就是滑出App时的App管理列表显示的标题，iOS用不上，iOS只能在info.plist设置",
      
      // 设置【主题】
      theme: JPAppTheme.baseThemeData,
      // 暗黑模式的主题
      darkTheme: JPAppTheme.dartThemeData,

      // 内容
      home: _DartThemePage(context)
      
    );
  }
}

class _DartThemePage extends StatelessWidget {
  final BuildContext _superCtx;

  _DartThemePage(this._superCtx);

  @override
  Widget build(BuildContext context) {

    // 可通过 Theme.of(context) 获取祖先的主题数据（当前使用的）
    ThemeData theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DartThemeExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text 颜色想依赖 ThemeData 的主颜色需要自行设置，默认使用的是 ThemeData.TextTheme.bodyText2
            Text(
              "Hello~", 
              style: TextStyle(fontSize: 30, color: theme.colorScheme.primary)
            ),

            Switch(
              value: true, 
              onChanged: (value) => JPrint(value),
            ),

            // iOS风格的开关，颜色不依赖 ThemeData，需要自行设置
            CupertinoSwitch(
              value: true, 
              onChanged: (value) => JPrint(value), 
              activeColor: theme.colorScheme.primary,
            ),

            ElevatedButton(
              child: Icon(Icons.face),
              onPressed: () {},
            ),

            Card(
              child: Text("😁好", style: TextStyle(fontSize: 25)),
            ),

            // 不设置style，会默认使用 TextTheme.bodyText2
            Text("Hello Baby",), 
            // 只设置了部分style，剩下的会默认使用 TextTheme.bodyText2 对应的属性
            Text("Hello Baby", style: TextStyle(fontSize: 15)), 
            // TextTheme 提供的其他样式（也可自定义）
            Text("headline1", style: theme.textTheme.headline1,),
            Text("headline2", style: theme.textTheme.headline2,),
            Text("headline3", style: theme.textTheme.headline3,),
            Text("headline4", style: theme.textTheme.headline4,),
            Text("headline5", style: theme.textTheme.headline5,),
            Text("headline6", style: theme.textTheme.headline6,),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sanitizer),
            label: "首页"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio),
            label: "个人"
          ),
        ],
      ),
      
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // FloatingActionButton(
          //   heroTag: 1, // 如果有多个 FloatingActionButton 会导致 heroTag 的冲突，要分别设置跟其他不一样的 heroTag
          //   child: Icon(Icons.arrow_forward_ios),
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(builder: (context) => _GlobalThemeDemoPage())
          //     );
          //   },
          // ),

          // SizedBox(height: 8),

          FloatingActionButton(
            heroTag: 2, // 如果有多个 FloatingActionButton 会导致 heroTag 的冲突，要分别设置跟其他不一样的 heroTag
            child: Icon(Icons.close),
            onPressed: () {
              Navigator.of(_superCtx).pop();
            },
          )
        ],
      )
      
    );
  }
}