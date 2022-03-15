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

  void addAB() {
    a += 1;
    b += 1;
    
    refresh();

    JPrint("加ab a: $a, b: $b");
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
            child: Text('+ab'),
            onPressed: () {
              _ctr.addAB();
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
        ],
      ),
    );
  }
}