import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'package:get/get.dart';
import 'package:jp_flutter_demo/shared/JPGetxController.dart';

class JPGetxExample extends StatelessWidget {
  static String title = "3.Getx Example";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPGetxExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: JPGetxPage(),

    );
  }
}

class JPGetxCtr extends JPGetxController {
  var a = 0.obs; 
  var b = 0.obs; 
  int c = 0;

  void addA() {
    
    a += 1;
    a.refresh();

    JPrint("加a $a");
  }

  void addB() {
    b += 1;
    b.refresh();

    JPrint("加b $b");
  }

  void addABC() {
    a += 1;
    b += 1;
    c += 1;
    refresh();

    JPrint("加abc a: $a, b: $b, c: $c");
  }
}

class JPGetxPage extends StatefulWidget {
  @override
  _JPGetxPageState createState() => _JPGetxPageState();
}
class _JPGetxPageState extends State<JPGetxPage> {

  late JPGetxCtr _ctr;
  
  @override
  void initState() {
    super.initState();
    _ctr = JPGetxCtr();
  }

  @override
  void dispose() {
    _ctr.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // 监听 a
          ObxValue(
            (a) {
              JPrint("ObxValue(a) 刷新");
              return Text("ObxValue(a) - $a", style: TextStyle(fontSize: 30, color: JPRandomColor()),);
            },
            _ctr.a,
          ),
          Obx(
            () {
              JPrint("Obx(a) 刷新");
              return Text("Obx(a) - ${_ctr.a}", style: TextStyle(fontSize: 30, color: JPRandomColor()),);
            },
          ),

          // 监听 b
          ObxValue(
            (b) {
              JPrint("ObxValue(b) 刷新");
              return Text("ObxValue(b) - $b", style: TextStyle(fontSize: 30, color: JPRandomColor()),);
            },
            _ctr.b,
          ),
          Obx(
            () {
              JPrint("Obx(b) 刷新");
              return Text("Obx(b) - ${_ctr.b}", style: TextStyle(fontSize: 30, color: JPRandomColor()),);
            },
          ),

          // 监听 c ？
          // 没有.obs的变量无法通过Obx监听实时变化，这种情况只能调用setState刷新
          Text("Obx(c) - ${_ctr.c}", style: TextStyle(fontSize: 30, color: JPRandomColor()),),

          // 尽管 ObxValue 目标是 a，只要 builder 里面的对象 b 发生变化，就会刷新
          ObxValue(
            (a) {
              JPrint("ObxValue(a) 刷新b");
              return Text("ObxValue(a) b: ${_ctr.b}", style: TextStyle(fontSize: 30, color: JPRandomColor()),);
            },
            _ctr.a,
          ),

          // 尽管 ObxValue 目标是 b，只要 builder 里面的对象 a 发生变化，就会刷新
          ObxValue(
            (b) {
              JPrint("ObxValue(b) 刷新a");
              return Text("ObxValue(b) a: ${_ctr.a}", style: TextStyle(fontSize: 30, color: JPRandomColor()),);
            },
            _ctr.b,
          ),
          

          ElevatedButton(
            child: Text('+a'),
            onPressed: () {
              _ctr.addA();
            },
          ),

          ElevatedButton(
            child: Text('+b'),
            onPressed: () {
              _ctr.addB();
            },
          ),

          ElevatedButton(
            child: Text('+abc'),
            onPressed: () {
              _ctr.addABC();
            },
          ),

          Obx(
            () {
              JPrint("Obx(a) + Obx(b) 刷新");
              return Container(
                color: JPRandomColor(),
                child: Column(
                  children: [
                    Text("Obx(a) - ${_ctr.a}", style: TextStyle(fontSize: 30, color: JPRandomColor()),),
                    Text("Obx(b) - ${_ctr.b}", style: TextStyle(fontSize: 30, color: JPRandomColor()),),
                    Text("111111", style: TextStyle(fontSize: 30, color: JPRandomColor()),),
                  ],
                ),
              );
            },
          ),

          Obx(
            () {
              JPrint("Obx(a) + Obx(b) 刷新");
              return Column(
                children: [
                  Text("Obx(a) - ${_ctr.a}", style: TextStyle(fontSize: 30, color: JPRandomColor()),),
                  Text("Obx(b) - ${_ctr.b}", style: TextStyle(fontSize: 30, color: JPRandomColor()),),
                  Text("222222", style: TextStyle(fontSize: 30, color: JPRandomColor()),),
                ],
              );
            },
          ),

          // 总结：ObxValue/Obx 的刷新条件取决于 builder 里面的”捕获“的【obs对象】是否发生改变，如果不是对应的obs对象就不会重复刷新
          // 刷新的是”捕获“的【obs对象】所在的 ObxValue/Obx 包裹的 widget 树

          ElevatedButton(
            child: Text("去新页面 使用同一个GetxCtr"),
            onPressed: (){
              JPPush(widget: JPSSSDemo(_ctr), context: context);
            },
          ),
        ],
      ),
    );
  }
}



// =========================== 使用同一个JPGetxCtr的页面 ===========================

class JPSSSDemo extends StatelessWidget {
  final JPGetxCtr ctr;
  JPSSSDemo(this.ctr);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "哥只是个替身",
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
      backgroundColor: JPRandomColor(),
      body: _JPSSSDemo(ctr),
    );
  }
}

class _JPSSSDemo extends StatefulWidget {
  final JPGetxCtr ctr;
  _JPSSSDemo(this.ctr);

  @override
  _JPSSSDemoState createState() => _JPSSSDemoState();
}
class _JPSSSDemoState extends State<_JPSSSDemo> {
  @override
  Widget build(BuildContext context) {
    // 使用上一个页面传递过来的GetxCtr
    JPGetxCtr ctr = widget.ctr;
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // 监听 a
          ObxValue(
            (a) {
              JPrint("ObxValue(a) 刷新");
              return Text("ObxValue(a) - $a", style: TextStyle(fontSize: 30, color: JPRandomColor()),);
            },
            ctr.a,
          ),
          Obx(
            () {
              JPrint("Obx(a) 刷新");
              return Text("Obx(a) - ${ctr.a}", style: TextStyle(fontSize: 30, color: JPRandomColor()),);
            },
          ),

          // 监听 b
          ObxValue(
            (b) {
              JPrint("ObxValue(b) 刷新");
              return Text("ObxValue(b) - $b", style: TextStyle(fontSize: 30, color: JPRandomColor()),);
            },
            ctr.b,
          ),
          Obx(
            () {
              JPrint("Obx(b) 刷新");
              return Text("Obx(b) - ${ctr.b}", style: TextStyle(fontSize: 30, color: JPRandomColor()),);
            },
          ),

          // 尽管 ObxValue 目标是 a，只要 builder 里面的对象 b 发生变化，就会刷新
          ObxValue(
            (a) {
              JPrint("ObxValue(a) 刷新b");
              return Text("ObxValue(a) b: ${ctr.b}", style: TextStyle(fontSize: 30, color: JPRandomColor()),);
            },
            ctr.a,
          ),

          // 尽管 ObxValue 目标是 b，只要 builder 里面的对象 a 发生变化，就会刷新
          ObxValue(
            (b) {
              JPrint("ObxValue(b) 刷新a");
              return Text("ObxValue(b) a: ${ctr.a}", style: TextStyle(fontSize: 30, color: JPRandomColor()),);
            },
            ctr.b,
          ),
          

          ElevatedButton(
            child: Text('+a'),
            onPressed: () {
              ctr.addA();
            },
          ),

          ElevatedButton(
            child: Text('+b'),
            onPressed: () {
              ctr.addB();
            },
          ),

          ElevatedButton(
            child: Text('+abc'),
            onPressed: () {
              ctr.addABC();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    JPrint("_JPSSSDemoState dispose");
  }
}