import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844904176321839118 */

class AnimatedWidgetExample extends StatefulWidget {
  static String title = "12.动画 AnimatedWidget";
  final Color _bgColor = JPRandomColor();
  final Color _iconColor = JPRandomColor();
  @override
  _AnimatedWidgetExampleState createState() => _AnimatedWidgetExampleState();
}

class _AnimatedWidgetExampleState extends State<AnimatedWidgetExample> with SingleTickerProviderStateMixin {
  late AnimationController _animCtr;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    
    _animCtr = AnimationController(vsync: this, duration: Duration(seconds: 2));

    // CurvedAnimation：设置动画曲线，返回一个新的 Animation 对象
    _anim = CurvedAnimation(curve: Curves.elasticInOut, parent: _animCtr);

    // Tween：自定义设置动画值范围，返回一个新的 Animation 对象
    _anim = Tween<double>(begin: 50, end: 100).animate(_anim);

    // 由于每次设置都会返回<不同子类类型>的 Animation 对象，因此开发中一般都使用一个 Animation 类型的属性来保存这个<不确定真实子类类型>的动画对象

    // AnimatedWidget listenable 内部会自动监听 Animation 的动画值的改变，并且会自动重新执行 build 方法进行刷新
    // 这里就不用监听了
    // _anim.addListener(() {
    //   setState(() {});
    // });

    // 监听动画状态的改变
    _anim.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.dismissed) {
          _animCtr.forward();
        } else if (status == AnimationStatus.completed) {
          _animCtr.reverse();
        }
      });
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
          AnimatedWidgetExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: widget._bgColor,

      body: Center(
        child: _AnimatedWidgetDemo(_anim, iconColor: widget._iconColor)
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(_animCtr.isAnimating ? Icons.pause : Icons.play_arrow),
        onPressed: () {
          setState(() {
            if (_animCtr.isAnimating) {
              stop();
            } else {
              play();
            }
          });
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

class _AnimatedWidgetDemo extends AnimatedWidget {
  final Color _iconColor;
  _AnimatedWidgetDemo(Animation anim, {required Color iconColor}) : this._iconColor = iconColor, super(listenable: anim); // 要先初始化完自己其他属性才能去调用父类的构造函数

  @override
  Widget build(BuildContext context) {
    // AnimatedWidget listenable 内部会自动监听 Animation 的动画值的改变，并且会自动重新执行 build 方法进行刷新
    // 对比之前的方案，唯一的好处就是 父Widget 不会不断地重新 build，只有自身会（消耗小一点点）
    Animation<double> anim = listenable as Animation<double>;
    return Icon(Icons.favorite, color: _iconColor, size: anim.value,);
  }
}