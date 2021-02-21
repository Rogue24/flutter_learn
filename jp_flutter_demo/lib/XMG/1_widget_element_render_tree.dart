import 'package:flutter/material.dart';

/* 学自：https://juejin.cn/post/6844904170571431944 */

class TreeExample extends StatelessWidget {
  static String title = "Tree: Widget-Element-Render";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TreeExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
      backgroundColor: Colors.lime,

      body: _DemoWidget()
    );
  }
}

class _DemoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    /*
     * Widget
     * Widget就是一个个描述文件，这些描述文件在我们进行状态改变时会不断的build。
     * Widget非常不稳定，只要有地方修改或改变就会销毁重新创建（build）。
     * 但是对于渲染对象来说，只会使用最小的开销来更新渲染界面。
     *
     * Element
     * Element是一个Widget的实例，在树中详细的位置。
     * Element比较稳定，只修改Widget前后不同的地方。
     * Widget描述和配置子树的样子，而Element实际去配置在Element树中特定的位置。
     * 【 所有的 Widget 都会创建一个对应的 Element 对象（当前类里面没有实现的话那肯定是父类实现好了）】
     * StatelessWidget.createElement -> StatelessElement -> ComponentElement
     * StatefulWidget.createElement -> StatefulElement -> ComponentElement
     * Padding -> SingleChildRenderObjectWidget.createElement -> SingleChildRenderObjectElement -> RenderObjectElement
     *
     * RenderObject
     * 渲染树上的一个对象
     * RenderObject层是渲染库的核心。
     */

    // Container、Text 属于 组装Widget，不会生成 RenderObject
    // 这种 Widget 只是将其他的 Widget 在 build 方法中组装起来，并不是一个真正可以渲染的 Widget

    // Padding、Row 属于 渲染Widget，会生成 RenderObject，是真正可以渲染的 Widget
    // Padding -> SingleChildRenderObjectWidget -> RenderObjectWidget -> Widget
    // Padding.createRenderObject() -> RenderPadding -> RenderShiftedBox -> RenderBox -> RenderObject
    Padding(padding: EdgeInsets.zero);

    // Container -> StatelessWidget -> Widget
    return Container(color: Colors.amber,);

    // createRenderObject 是 抽象类RenderObjectWidget 的方法，交给（有能力实现的）子类去实现
    // PS：SingleChildRenderObjectWidget 也是一个抽象类，因此方法的实现再丢给其子类
    // 组装Widget（如 StatelessWidget）就没有 createRenderObject 方法

    /*
     * 组装Widget 和 渲染Widget 最终都继承于 Widget
     * Widget 是个抽象类，里面有个 createElement 方法，其子类必须要有其方法的实现（如果当前类里面没有实现的话那肯定是某个父类实现好了）
     * 所有的 Widget 都会创建一个对应的 Element 对象（不同的 Widget 创建的 Element 是不同的）
     * 
     * 平时创建的 Widget 的 build 方法是在 Element 创建过程中最终调用 _widget.build() 时执行的
     * Element -> mount() -> _firstBuild() -> rebuild() -> performRebuild() -> build() -> 最终目的：_widget.build(this) / _state.build(this)
     * mount函数：当新创建的 Element 第一次添加到树中时，框架会调用此函数。
     * 
     * StatelessWidget.createElement() -> StatelessElement -> ... -> _widget.build(this)
     * StatefulWidget.createElement() -> StatefulElement -> ... -> _state.build(this)
     * _widget.build(this) 也就是调用 StatelessWidget 的 build(BuildContext context) 方法，里面的 context 就是 StatelessElement
     * _state.build(this) 也就是调用 StatefulWidget 的 State 的 build(BuildContext context) 方法，里面的 context 就是 StatefulElement
     *
     * 渲染Widget 的 RenderObject 也是在 Element 创建过程中最终调用 createRenderObject 时创建的
     * Element -> mount() -> _renderObject = _widget.createRenderObject(this) -> 最终目的：创建 RenderObjectElement
     *
     * Element 有这两个属性：_widget（在 Widget Tree） 和 _renderObject（在 Render Tree）
     * 是 StatefulElement 的话，还有一个 state 属性，通过 createState 方法创建，该方法是在 StatefulElement 的【构造方法】中执行的
     * 并且在构造方法中会把 widget 赋值给 state -> state._widget = widget，因此可以在 XXXState 里面通过 this.widget 获取对应的 widget 对象
     */
  }
}