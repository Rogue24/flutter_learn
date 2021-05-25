import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

class JPFrameExample extends StatelessWidget {
  static String title = "Frame Example";

  final GlobalKey<_JPFrameDemoState> gbKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPFrameExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: JPFrameDemo(gbKey),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: () {
          var state = gbKey.currentState;
          state.doSomeThing();
        },
      ),

    );
  }
}

class JPFrameDemo extends StatefulWidget {
  @override
  _JPFrameDemoState createState() => _JPFrameDemoState();

  JPFrameDemo(Key key) : super(key: key);
}

class _JPFrameDemoState extends State<JPFrameDemo> {

  GlobalKey _key1 = GlobalKey();
  GlobalKey _key2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            left: 70,
            top: 20,
            child: Container(
              key: _key1,
              child: Center(child: Text("我喜欢你", style: TextStyle(fontSize: 20, color: JPRandomColor()))), 
              width: 200, 
              height: 200, 
              color: JPRandomColor()
            ),
          ),

          Positioned(
            right: 20,
            bottom: 120,
            child: Container(
              key: _key2,
              child: Center(child: Text("你呢亲", style: TextStyle(fontSize: 20, color: JPRandomColor()))), 
              width: 150, 
              height: 150, 
              color: JPRandomColor()
            ),
          ),
        ],
      ),
    );
  }

  void doSomeThing() {
    // JPrint("onTapDown globalPosition: ${details.globalPosition}"); // 相对于【屏幕】
    // JPrint("onTapDown localPosition: ${details.localPosition}"); // 相对于【子Widget】

    RenderBox renderBox1 = _key1.currentContext.findRenderObject();
    var size1 = renderBox1.size;
    var position1 = renderBox1.localToGlobal(Offset.zero);

    JPrint("size1: $size1");
    JPrint("position1: $position1");
    
    RenderBox renderBox2 = _key2.currentContext.findRenderObject();
    var size2 = renderBox2.size;
    var position2 = renderBox2.localToGlobal(Offset.zero);

    JPrint("size2: $size2");
    JPrint("position2: $position2");
  }
}