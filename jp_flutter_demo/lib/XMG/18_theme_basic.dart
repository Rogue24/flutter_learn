import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844903973791465480 */

class GlobalThemeExample extends StatelessWidget {
  static String title = "Theme 全局&局部";

  @override
  Widget build(BuildContext context) {

    /*
     * Color color = Colors.deepOrange; 
     * 
     * Colors.xxx => 属于 MaterialColor，是 Color 的子类
     * 父类引用 可以指向 子类对象，而 子类引用 不可以指向 父类对象
     * 因为父类有的，子类肯定都有，而子类有的，父类不一定会有。
     */
    
    /*
     * Color color = Colors.red[300];
     * 
     * MaterialColor 继承自 ColorSwatch
     * ColorSwatch 内部重写了运算符“[]”，使得可以直接在后面调用“[]”获取对应不同深浅的颜色：
        /// Returns an element of the swatch table.
        Color? operator [](T index) => _swatch[index];
     *
     * 例如：开关背后较浅的主题颜色就是系统通过该方式获取 
     */
    
    return MaterialApp(
      // 标题
      title: "App快照的标题，也就是滑出App时的App管理列表显示的标题，iOS用不上，iOS只能在info.plist设置",
      
      // 设置【主题】
      theme: ThemeData(
        // 亮度（设置【深色模式】）
        brightness: Brightness.light,

        // 脚手架背景色
        scaffoldBackgroundColor: Colors.limeAccent,

        // 主颜色（只能设置 MaterialColor 类型，是 primaryColor + accentColor 的结合体）
        primarySwatch: Colors.pink,
        // 主颜色：用于单独设置 导航栏背景 和 Tabbar图标+标题 的颜色（不设置则会使用 primarySwatch）
        primaryColor: Colors.deepOrange,
        // 次颜色：用于单独设置 FloatingActionButton 和 Switch 的颜色（不设置则会使用 primarySwatch）
        accentColor: Colors.amber,

        // 默认高亮时会有个波纹（安卓那种），设置颜色透明移除这个波纹
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,

        // 按钮主题
        buttonTheme: ButtonThemeData(
          height: 30,
          minWidth: 10,
          buttonColor: Colors.green
        ),

        // 卡片主题
        cardTheme: CardTheme(
          color: Colors.cyan,
          elevation: 10, // 阴影
          margin: EdgeInsets.all(30.0), // 跟外部其他widget的间距
        ),

        // 文本主题
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 10, color: Colors.red),
          bodyText2: TextStyle(fontSize: 50, color: Colors.teal), // 默认 Style（以前是 body1）
          headline1: TextStyle(fontSize: 15),
          headline2: TextStyle(fontSize: 20),
          headline3: TextStyle(fontSize: 25),
          headline4: TextStyle(fontSize: 30),
          headline5: TextStyle(fontSize: 35),
          headline6: TextStyle(fontSize: 40),
        ),

      ),

      // 内容
      home: _GlobalThemePage(context)
      
    );
  }
}

class _GlobalThemePage extends StatelessWidget {
  final BuildContext _superCtx;

  _GlobalThemePage(this._superCtx);

  @override
  Widget build(BuildContext context) {

    // 可通过 Theme.of(context) 获取祖先的主题数据（当前使用的）
    ThemeData theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          GlobalThemeExample.title,
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

            RaisedButton(
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
          FloatingActionButton(
            heroTag: 1, // 如果有多个 FloatingActionButton 会导致 heroTag 的冲突，要分别设置跟其他不一样的 heroTag
            child: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => _GlobalThemeDemoPage())
              );
            },
          ),

          SizedBox(height: 8),

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

class _GlobalThemeDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    // 可通过 Theme.of(context) 获取祖先的主题数据（当前使用的）
    ThemeData theme = Theme.of(context);
    JPrint(theme.colorScheme.primary);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GlobalThemeDemoPage",
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      body: Container(
        child: Center(
          child: Text("Hi~~",), // 样式使用祖先默认的 TextTheme.bodyText2
        ),
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: 3, // 如果有多个 FloatingActionButton 会导致 heroTag 的冲突，要分别设置跟其他不一样的 heroTag
        child: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => _LocalThemeDemoPage())
          );
        },
      )

    );
  }
}

class _LocalThemeDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 如果某个具体的Widget不希望直接使用全局的Theme，
    // 想使用局部Theme，只需要在Widget的父节点包裹一下Theme即可
    return Theme(
      // 自定义全新的主题
      // data: ThemeData(
      //   brightness: Brightness.dark,
      //   primarySwatch: Colors.red,
      //   accentColor: Colors.red,
      //   textTheme: TextTheme(
      //     bodyText2: TextStyle(fontSize: 70, color: Colors.amber), // 默认 Style（以前是 body1）
      //   ),
      // ), 

      // 或者在之前的主题基础之上进行修改（copyWith：拷贝、修改）
      // 开发中一般都只需要修改部分样式，很少新建一个全新的主题
      data: Theme.of(context).copyWith(
        primaryColor: Colors.brown,
        scaffoldBackgroundColor: Colors.indigo,
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 70, color: Colors.white60), // 默认 Style（以前是 body1）
        ),

        //【注意】：想在这里修改 FloatingActionButton 的颜色，修改 accentColor 是无效的
        // accentColor: Colors.red,
        // 要通过以下方式才能修改：
        colorScheme: Theme.of(context).colorScheme.copyWith(
          secondary: Colors.red
        ),
        
      ),

      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "LocalThemeDemoPage",
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),

        body: Container(
          child: Center(
            child: Text("Hi~~",), // 样式使用祖先默认的 TextTheme.bodyText2
          ),
        ),

        floatingActionButton: FloatingActionButton(
          heroTag: 3, // 如果有多个 FloatingActionButton 会导致 heroTag 的冲突，要分别设置跟其他不一样的 heroTag
          child: Icon(Icons.wallet_giftcard),
          onPressed: () {},
        )

      ),
    );
  }
}