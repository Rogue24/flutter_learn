// import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

// JP：这个库只能运行在真机环境，模拟器先注释！！！！！！！！

class JPFijkplayerTestViewExample extends StatelessWidget {
  static String title = "10.Fijkplayer Example";

  // final GlobalKey<_JPFijkplayerDemoState> gbKey = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPFijkplayerTestViewExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: Container(),// JPFijkplayerDemo(gbKey),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.show_chart_sharp),
        onPressed: () {
          // var state = gbKey.currentState;
          // state?.doSomeThing();
        },
      ),
      
    );
  }
}

// class JPFijkplayerDemo extends StatefulWidget {
//   final String url = "https://dhxy.v.netease.com/2019/0814/5757db881a2aff4543b7d9c846f3f415qt.mp4";
//   JPFijkplayerDemo(Key key) : super(key: key);

//   @override
//   _JPFijkplayerDemoState createState() => _JPFijkplayerDemoState();
// }

// class _JPFijkplayerDemoState extends State<JPFijkplayerDemo> {

//   final FijkPlayer _player = FijkPlayer();

//   @override
//   void initState() {
//     super.initState();
//     // 初始化播放器
//     _player.setDataSource(widget.url, autoPlay: false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: FijkView(
//         player: _player,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // 销毁播放器
//     _player.release();
//   }

//   void doSomeThing() {
//     _player.start();
//   }
// }