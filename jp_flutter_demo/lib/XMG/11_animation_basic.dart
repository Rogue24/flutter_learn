import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844904176321839118 */

class AnimationBasicExample extends StatefulWidget {
  static String title = "动画 基本使用";

  final GlobalKey<__AnimationBasicDemoState> _animKey = GlobalKey();
  final Color _bgColor = JPRandomColor();

  @override
  _AnimationBasicExampleState createState() => _AnimationBasicExampleState();
}

class _AnimationBasicExampleState extends State<AnimationBasicExample> {
  bool _isAnimating = false;

  @override
  Widget build(BuildContext context) {
    // JPrint("_AnimationBasicExampleState build");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AnimationBasicExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: widget._bgColor,

      body: Center(
        child: _AnimationBasicDemo(widget._animKey),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(_isAnimating ? Icons.pause : Icons.play_arrow),

        onPressed: () {
          setState(() {
            var widgetState = widget._animKey.currentState;

            if (widgetState.isAnimating()) {
              widgetState.stop();
            } else {
              widgetState.play();
            }

            _isAnimating = widgetState.isAnimating();
          });
        },

      ),
      
    );
  }
}

/*
 * Animation：抽象类（根类，子类负责实现）
 *  - value：动画值
 *  - status：动画状态
 *  - 监听动画值的改变
 *  - 监听动画状态的改变
 */

class _AnimationBasicDemo extends StatefulWidget {
  final Color _iconColor = JPRandomColor();

  _AnimationBasicDemo(Key key) : super(key: key);

  @override
  __AnimationBasicDemoState createState() => __AnimationBasicDemoState();
}

/*
 * AnimationController(vsync: this);
 * 
 * vsync：垂直同步信号，当 Flutter 接收到该信号时，会渲染一帧画面（iOS 1秒60帧）
 * 设置这个参数是为了监听 vsync 信号，
 * 当 Flutter 开发的应用程序不再接收同步信号时（比如锁屏或退到后台），那么继续执行动画会消耗性能，
 * 所以要给 vsync 设置一个 Ticker，这样没有接收同步信号时，就不会再触发动画了。
 * 
 * vsync 传入的参数类型是 TickerProvider
 * 开发中比较常见的是将 SingleTickerProviderStateMixin 混入到 StatefulWidget 的 State 的定义中
 *  - class XxxState extends State<Xxx> with SingleTickerProviderStateMixin
 *  - AnimationController(vsync: this) --- this = State<Xxx>
 */

/*
 * SingleTickerProviderStateMixin 是 TickerProvider 的子类，TickerProvider 是抽象类
 * mixin SingleTickerProviderStateMixin<T extends StatefulWidget> on State<T> implements TickerProvider
 * 
 * mixin ABC on xxx --- on：表示 ABC 只能在 xxx 中混入 
 * mixin ABC<T extends StatefulWidget> on State<T> --- 泛型 T 必须要继承于 StatefulWidget，ABC 只能被这个 T 的 State 混入
 */ 
class __AnimationBasicDemoState extends State<_AnimationBasicDemo> with SingleTickerProviderStateMixin {
  AnimationController _animCtr;
  Animation _anim;
  
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

  bool isAnimating() {
    return _animCtr.isAnimating;
  }

  AnimationStatus animStatus() {
    return _animCtr.status;
  }

  @override
  void initState() {
    super.initState();

    _animCtr = AnimationController(
      vsync: this, 
      duration: Duration(seconds: 2), 
      
      // 想要使用 CurvedAnimation，范围不能超过 0 ~ 1
      // 不设置默认就是 0 ~ 1
      // lowerBound: 50, 
      // upperBound: 100

      // 想要使用 Tween，不能设置 value，否则两者的动画值都会失效
      // value: 50, 

    );

    // CurvedAnimation：设置动画曲线，返回一个新的 Animation 对象
    _anim = CurvedAnimation(curve: Curves.elasticInOut, parent: _animCtr);

    // Tween：自定义设置动画值范围，返回一个新的 Animation 对象
    _anim = Tween<double>(begin: 50, end: 100).animate(_anim);

    // 由于每次设置都会返回<不同子类类型>的 Animation 对象，因此开发中一般都使用一个 Animation 类型的属性来保存这个<不确定真实子类类型>的动画对象

    // 监听动画值的改变
    _anim.addListener(() {
      setState(() {});
    });

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
    // 由于 父Widget 监听了动画值的改变，通过 setState 修改 size，所以自身和整个 父Widget 全部都会不断地重新 build（消耗大）
    // JPrint("__AnimationBasicDemoState build");
    return Icon(Icons.favorite, color: widget._iconColor, size: _anim.value);
  }
}




// ---------------- ↓↓↓ implements、mixin+with ↓↓↓ ----------------

// abstract：抽象类，只能声明不能实现
abstract class Cat {
  void run();
}

// 通过 mixin 定义的类用于被其他类混入使用，可声明也可实现
// 不能实例化  mixin 定义的类，要通过 with 关键字来进行混入，让其他类直接复用原有的实现方法
mixin Dog implements Cat {
  // implements 的方式要求必须对其中的方法进行重新实现
  @override
  void run() => JPrint("run");

  void sleep();

  void eat() => JPrint("eat");
}

// mixin+with 的方式可以不需要对其中的方法进行重新实现
class Person with Dog {
  @override
  void sleep() => JPrint("sleep");
}

class _Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    // var dog = Dog(); // 无法实例化
    // var per = Person(); // 只能被其他类混入使用

    return Container(
      
    );
  }
}

