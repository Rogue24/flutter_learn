import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'package:jp_flutter_demo/shared/JPSizeFit.dart';

class JPNestedScrollViewExample extends StatelessWidget {
  static String title = "8.NestedScrollView Example";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPNestedScrollViewExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: JPNestedScrollViewDemo(),
      
    );
  }
}

class JPNestedScrollViewDemo extends StatefulWidget {
  @override
  _JPNestedScrollViewDemoState createState() => _JPNestedScrollViewDemoState();
}

class _JPNestedScrollViewDemoState extends State<JPNestedScrollViewDemo> with SingleTickerProviderStateMixin {

  List<_JPTestPage> _tabBarViews = [];
  late TabController _tabCtr;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i ++) {
      _tabBarViews.add(_JPTestPage(i));
    }

    _tabCtr = TabController(
      length: _tabBarViews.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  /*
   * AlwaysScrollableScrollPhysics：总是可以滑动
   * NeverScrollableScrollPhysics：禁止滚动
   * BouncingScrollPhysics：内容超过一屏，上拉有回弹效果
   * ClampingScrollPhysics：包裹内容，不会有回弹
   * FixedExtentScrollPhysics：滚动条直接落在某一项上，而不是任何位置，类似于老虎机，只能在确定的内容上停止，而不能停在2个内容的中间，用于可滚动组件的FixedExtentScrollController。
   * PageScrollPhysics：用于PageView的滚动特性，停留在页面的边界
   */

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: ClampingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBox) {
        return <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false, // 不需要返回箭头
            pinned: true,
            floating: true,
            elevation: 0,
            expandedHeight: 300,
            backgroundColor: JPRandomColor(),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                "https://picsum.photos/${JPSizeFit.screenWidth.toInt()}/300",
                fit: BoxFit.fill,
              ),
            ),
            bottom: _buildTabBar(),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabCtr,
        children: _tabBarViews
      ),
    );
  }

  PreferredSize _buildTabBar() {
    List<Text> titles = [];
    titles.addAll(_tabBarViews.map((e) => Text("${e.index}")));
    return PreferredSize(
      preferredSize: Size.fromHeight(48), // 应该是最大尺寸，实际大小由`child`决定
      child: Container(
        height: 48,
        alignment: Alignment.center,
        color: JPRandomColor(),
        child: TabBar(
          tabs: titles,

          physics: BouncingScrollPhysics(),
          isScrollable: true,
          controller: _tabCtr,

          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 5.0,
          indicatorColor: Colors.white,
          
          labelStyle: TextStyle(fontSize: 18),
          labelColor: Colors.white,
          unselectedLabelColor: Color.fromRGBO(255, 255, 255, 0.5),
        ),
      ),
    );
  }
  
}

class _JPTestPage extends StatefulWidget {
  final int index;
  _JPTestPage(this.index);

  @override
  _JPTestPageState createState() => _JPTestPageState();
}

class _JPTestPageState extends State<_JPTestPage> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true; // 切换tab，默认会销毁并重新创建，返回true防止销毁

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: JPRandomColor(),
      child: ListView.builder(
        itemCount: 50,
        itemExtent: 50,
        itemBuilder: (BuildContext context, int index) { 
          print("显示时才创建 --- $index");
          return ListTile(
            title: Text("${widget.index} --- 第${index + 1}个", style: TextStyle(fontSize: 15)),
            tileColor: JPRandomColor(),
          );
        },
      )
    );
  }

}