import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'package:jp_flutter_demo/viewModel/counter_viewModel.dart';
import 'package:jp_flutter_demo/viewModel/moguBanner_viewModel.dart';
import 'package:provider/provider.dart';

/* 学自：https://juejin.cn/post/6844904174115618830 */

// Provider 用于全局共享，在 main.dart 中将 主体Widget（MyApp）包裹住

class ProviderExample extends StatelessWidget {
  static String title = "5.Provider";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ProviderExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: _JPDemo(),

      /*
       * Consumer：消费者，使用共享数据的消费者
       * 使用 Consumer 包裹 子Widget，让 子Widget 在里面能直接拿到 viewModel
       */
      // floatingActionButton: Consumer<JPCounterViewModel>(
      //   builder: (ctx, counterVM, child) {
      //     JPrint("Consumer.builder --- build");
      //     return FloatingActionButton(
      //       child: child,
      //       onPressed: () {
      //         // JPrint(ctx.widget);
      //         counterVM.counter += 1;
      //       },
      //     );
      //   },
      //   child: Icon(Icons.add) // 目的是进行优化，如果builder下面有一颗庞大的子树，当模型发生改变的时候，我们并不希望重新build这颗子树，那么就可以将这颗子树放到Consumer的child中，在这里直接引入即可
      // ),

      /*
       * 此处是 Provider 使用步骤的：3.3 Selector: 基本功能跟 Consumer 一样
       *  - 比 Consumer 多出：1.selector方法(作用：对原有的数据进行转换) 2.shouldRebuild(作用：要不要重新构建)
       *  - 若 Consumer.builder 返回的 widget 不需要依赖共享数据（样式没变化），可以在 shouldRebuild 中返回false：当共享数据发生变化时不要重新构建
       * 
       * Selector<A, S>
       * @required ValueWidgetBuilder<S> builder,
       *  - ValueWidgetBuilder<T> = Widget Function(BuildContext context, T value, Widget? child);
       * @required S Function(BuildContext, A) selector,
       */
      floatingActionButton: Selector<JPCounterViewModel, JPCounterViewModel>(
        builder: (ctx, counterVM, child) {
          JPrint("Selector.builder --- build");
          return FloatingActionButton(
            child: child,
            onPressed: () {
              // JPrint(ctx.widget);
              counterVM.counter += 1;
            },
          );
        },
        child: Icon(Icons.add),

        // selector 用于类型转换，把 A -> S 的操作丢在函数里面，如果不需要转换直接返回 S
        // 类似 Swift 的 map 函数
        selector: (ctx, counterVM) => counterVM,
        // Selector<A, S>： ↑A↑          ↑S↑

        // 是否需要重新构建（返回true，Selector.builder 会重新 build）
        shouldRebuild: (oldVM, newVM) {
          // return oldVM.counter != newVM.counter;
          return false; // 返回false不重建，因为样式不会跟随共享数据的变化而变化
        },
      ),
      
    );
  }
}

class _JPDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _JPDemo1(),
          _JPDemo2(),
          _JPDemo3() 
        ],
      ),
    );
  }
}

class _JPDemo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
     * 此处是 Provider 使用步骤的：3.1 Provider.of: 当Provider中的数据发生改变时, Provider.of所在的Widget整个build方法都会重新构建
     *  - 使用 Provider.of<T>(context) 获取对应的 Provider 对象
     */
    int counter = Provider.of<JPCounterViewModel>(context).counter;

    JPrint("_JPDemo1 --- build");

    return Card(
      color: JPRandomColor(),
      child: Text("$counter", style: TextStyle(fontSize: 30, color: JPRandomColor())),
    );
  }
}

class _JPDemo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    JPrint("_JPDemo2 --- build");

    return Card(
      color: JPRandomColor(),
      /*
       * 此处是 Provider 使用步骤的：3.2 Consumer: 当Provider中的数据发生改变时, 执行重新执行Consumer的builder
       *  - 使用 Consumer 包裹 子Widget，让 子Widget 在里面能直接拿到 viewModel
       *  - 不会重新构建 Consumer 所在的 widget，只会重新构建 Consumer.builder 返回的 widget
       */
      child: Consumer<JPCounterViewModel>(
        builder: (ctx, counterVM, child) {
          JPrint("_JPDemo2.Consumer --- build");
          return Text("${counterVM.counter}", style: TextStyle(fontSize: 30, color: JPRandomColor()));
        }
      ),
    );
  }
}

class _JPDemo3 extends StatefulWidget {
  @override
  __JPDemo3State createState() => __JPDemo3State();
}
class __JPDemo3State extends State<_JPDemo3> {
  // 触发情况一：调用 initState 调用
  // 触发情况二：从其他对象中依赖一些数据发生改变时，比如 InheritedWidget
  // 使用 provider 不会触发 didChangeDependencies
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    JPrint("JPDemo3 执行 State 的 didChangeDependencies 方法");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: JPRandomColor(),
      /*
       * 此处是 Provider 使用步骤的：3.2 Consumer: 当Provider中的数据发生改变时, 执行重新执行Consumer的builder
       *  - 使用 Consumer 包裹 子Widget，让 子Widget 在里面能直接拿到 viewModel
       *  - 不会重新构建 Consumer 所在的 widget，只会重新构建 Consumer.builder 返回的 widget
       * 
       * Consumer2：共享两个类型的数据（ConsumerX：共享X个类型的数据）
       */
      child: Consumer2<JPCounterViewModel, JPMoguBannerViewModel>(
        builder: (ctx, counterVM, moguBannerVM, child) {
          return Text(
            "${moguBannerVM.moguBanner.title} --- ${counterVM.counter}", 
            style: TextStyle(fontSize: 30, color: JPRandomColor())
          );
        }
      ),
    );
  }
}