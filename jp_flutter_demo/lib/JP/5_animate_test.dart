import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

class JPAnimateExample extends StatelessWidget {
  static String title = "Animate Example";

  final GlobalKey<_JPAnimateDemoState> gbKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPAnimateExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: JPAnimateDemo(gbKey),
      
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

class JPAnimateDemo extends StatefulWidget {
  @override
  _JPAnimateDemoState createState() => _JPAnimateDemoState();

  JPAnimateDemo(Key key) : super(key: key);
}

class _JPAnimateDemoState extends State<JPAnimateDemo> with SingleTickerProviderStateMixin {

  double begin = 50;
  double end = 100;

  AnimationController _animCtr;
  Animation _anim;
  Animation _sizeAnim;
  
  @override
  void initState() {
    super.initState();
    
    // 动画控制器
    _animCtr = AnimationController(vsync: this, duration: Duration(seconds: 2));
    // CurvedAnimation：设置动画曲线，返回一个新的 Animation 对象
    _anim = CurvedAnimation(curve: Curves.elasticInOut, parent: _animCtr);

    _sizeAnim = Tween<double>(begin: this.begin, end: this.end).animate(_anim);
  }
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _anim,
        builder: (context, child) {
          return Container(
            color: Colors.amberAccent,
            alignment: Alignment.center,
            width: _sizeAnim.value,
            height: _sizeAnim.value,
          );
        },
      ),
    );
  }

  void doSomeThing() {
    if (_animCtr.isAnimating) return;
    JPrint("开始~~");
    
    _animCtr.forward().then((value) {
      begin = end;
      end += 50;

      _sizeAnim = Tween<double>(begin: this.begin, end: this.end).animate(_anim);
      _animCtr.reset();
    });
  }
}