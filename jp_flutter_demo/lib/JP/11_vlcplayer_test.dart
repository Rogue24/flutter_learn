import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:jp_flutter_demo/JPLog.dart';

class JPVlcplayerTestViewExample extends StatelessWidget {
  static String title = "11.vlc_player Example";

  final GlobalKey<_JPVlcplayerDemoState> gbKey = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPVlcplayerTestViewExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: JPVlcplayerDemo(gbKey),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.show_chart_sharp),
        onPressed: () {
          var state = gbKey.currentState;
          state?.doSomeThing();
        },
      ),
      
    );
  }
}

class JPVlcplayerDemo extends StatefulWidget {
  final String url = "https://media.w3.org/2010/05/sintel/trailer.mp4";
  JPVlcplayerDemo(Key key) : super(key: key);

  @override
  _JPVlcplayerDemoState createState() => _JPVlcplayerDemoState();
}

class _JPVlcplayerDemoState extends State<JPVlcplayerDemo> {

  late VlcPlayerController _vlcPlayerCtr;

  @override
  void initState() {
    super.initState();
    // 初始化播放器
    _vlcPlayerCtr = VlcPlayerController.network(
      widget.url,
      hwAcc: HwAcc.full,
      autoPlay: false,
      options: VlcPlayerOptions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: VlcPlayer(
          controller: _vlcPlayerCtr,
          aspectRatio: 16 / 9,
          placeholder: Center(child: CircularProgressIndicator()),
        ),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    // 销毁播放器
    await _vlcPlayerCtr.stopRendererScanning();
    await _vlcPlayerCtr.dispose();
  }

  void doSomeThing() {
    _vlcPlayerCtr.play();
  }
}