import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844904176321839118 */

class AnimatedBuilderExample extends StatefulWidget {
  static String title = "动画 AnimatedBuilder";
  final Color _bgColor = JPRandomColor();
  final Color _iconColor = JPRandomColor();
  @override
  _AnimatedBuilderExampleState createState() => _AnimatedBuilderExampleState();
}

class _AnimatedBuilderExampleState extends State<AnimatedBuilderExample> with SingleTickerProviderStateMixin {
  AnimationController _animCtr;
  Animation _anim;
  
  @override
  void initState() {
    super.initState();
    
    _animCtr = AnimationController(vsync: this, duration: Duration(seconds: 2));

    // CurvedAnimation：设置动画曲线，返回一个新的 Animation 对象
    _anim = CurvedAnimation(curve: Curves.elasticInOut, parent: _animCtr);

    // Tween：自定义设置动画值范围，返回一个新的 Animation 对象
    _anim = Tween<double>(begin: 50, end: 100).animate(_anim);

    // 由于每次设置都会返回<不同子类类型>的 Animation 对象，因此开发中一般都使用一个 Animation 类型的属性来保存这个<不确定真实子类类型>的动画对象

    // AnimatedBuilder 跟 AnimatedWidget 一样内部会自动监听 Animation 的动画值的改变
    // 发生变化时，AnimatedWidget 会重新执行 build 方法进行刷新，而 AnimatedBuilder 会调用自身的 builder 方法
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
          AnimatedBuilderExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: widget._bgColor,

      body: Center(
        // 使用 AnimatedBuilder，不需要每次都要新建一个来继承自 AnimatedWidget 的类
        // AnimatedBuilder 用法跟 AnimatedWidget 差不多
        child: AnimatedBuilder(
          animation: _anim,
          builder: (ctx, child) => Icon(Icons.favorite, color: widget._iconColor, size: _anim.value,),

          // child: Icon(Icons.favorite, color: widget._iconColor, size: _anim.value,),
          /**
           * child 这个属性会在 builder 方法里面作为参数返回，也就是 builder: (ctx, child) 里面的 child
           * 跟 Consumer 一样的设计，目的是进行优化：如果builder下面有一颗庞大的子树，当模型发生改变的时候，我们并不希望重新build这颗子树，那么就可以将这颗子树放到Consumer的child中，在这里直接引入即可
           * 由于这里要跟随动画值不断刷新，所以不使用这个属性（适用于只监听动画值，不会变化的widget）
           */

        )
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