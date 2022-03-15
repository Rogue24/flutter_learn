import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844904176321839118 */

class AnimatedInterweaveExample extends StatefulWidget {
  static String title = "14.动画 交织动画";
  final GlobalKey<__ButtonIconState> _btnIconKey = GlobalKey();
  @override
  _AnimatedInterweaveExampleState createState() => _AnimatedInterweaveExampleState();
}

class _AnimatedInterweaveExampleState extends State<AnimatedInterweaveExample> with SingleTickerProviderStateMixin {
  late AnimationController _animCtr;
  late Animation<double> _anim;
  
  @override
  void initState() {
    super.initState();
    
    // 动画控制器
    _animCtr = AnimationController(vsync: this, duration: Duration(seconds: 2));
    // CurvedAnimation：设置动画曲线，返回一个新的 Animation 对象
    _anim = CurvedAnimation(curve: Curves.elasticInOut, parent: _animCtr);

    // 这里就不用监听动画值的变化了，当发生变化时，AnimatedBuilder 会调用自身的 builder 方法进行刷新
    // _anim.addListener(() {
    //   widget._animKey.currentState.setState(() {});
    // });

    // 监听动画状态的改变
    _anim.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _animCtr.forward();
      } else if (status == AnimationStatus.completed) {
        _animCtr.reverse();
      }
    });
  }

  @override
  void dispose() {
    //【注意】：要在自身销毁前，先销毁动画，否则会一直执行（浪费资源）
    JPrint("销毁动画");
    _animCtr.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AnimatedInterweaveExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: Center(child: _AnimationInterweaveDemo(_anim)),

      floatingActionButton: FloatingActionButton(
        child: _ButtonIcon(widget._btnIconKey, _animCtr.isAnimating),
        onPressed: () {
          if (_animCtr.isAnimating) {
            stop();
          } else {
            play();
          }
          var iconState = widget._btnIconKey.currentState;
          iconState?.setState(() => iconState.isAnimating = _animCtr.isAnimating);
        },
      ),
      
    );
  }
  
  void play() {
    if (_animCtr.isAnimating) return;

    if (_anim.status == AnimationStatus.reverse) {
      JPrint("play -- 继续反转");
      _animCtr.reverse(); 
    } else if (_anim.status == AnimationStatus.forward) {
      JPrint("play -- 继续向前");
      _animCtr.forward();
    } else {
      JPrint("play -- 开始动画");
      _animCtr.forward();
    }
  }

  void stop() {
    if (!_animCtr.isAnimating) return;
    _animCtr.stop();
    JPrint("stop");
  }
}

class _ButtonIcon extends StatefulWidget {
  final bool isAnimating;
  _ButtonIcon(Key key, this.isAnimating) : super(key: key);

  @override
  __ButtonIconState createState() => __ButtonIconState(isAnimating);
}

class __ButtonIconState extends State<_ButtonIcon> {
  bool isAnimating;
  __ButtonIconState(this.isAnimating);

  @override
  void initState() {
    super.initState();
    JPrint("_ButtonIcon initState");
  }

  @override
  Widget build(BuildContext context) {
    return Icon(isAnimating ? Icons.pause : Icons.play_arrow);
  }
}

class _AnimationInterweaveDemo extends StatelessWidget {
  final Animation<double> _anim;
  final Animation _sizeAnim;
  final Animation _colorAnim;
  final Animation _opacityAnim;
  final Animation _radiansAnim;

  _AnimationInterweaveDemo(this._anim) : 
  // Tween：自定义设置动画值范围，返回一个新的 Animation 对象
  this._sizeAnim = Tween<double>(begin: 100, end: 200).animate(_anim),
  this._colorAnim = ColorTween(begin: JPRandomColor(), end: JPRandomColor()).animate(_anim),
  this._opacityAnim = Tween<double>(begin: 1, end: 0.5).animate(_anim),
  this._radiansAnim = Tween<double>(begin: 0, end: pi * 2).animate(_anim);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnim.value > 1 ? 1 : (_opacityAnim.value < 0 ? 0 : _opacityAnim.value),
          child: Transform(
            child: Container(
              width: _sizeAnim.value,
              height: _sizeAnim.value,
              color: _colorAnim.value,
              // 单纯对 Container 设置 alignment 无效，锚点还是在默认的【左上角】，需要使用 Transform 包裹，形变的操作在 Transform 上进行
              // transform: Matrix4.rotationZ(pi / 4),
              // alignment: Alignment.center, 
            ),
            transform: Matrix4.rotationZ(_radiansAnim.value),
            alignment: Alignment.center, // 类似 iOS 的锚点，0 为中点，范围 -1 ~ 1
          ),
        );
      },
    );
  }
}