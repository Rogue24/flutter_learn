
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:jp_flutter_module/shared/JPLog.dart';

class JPTest extends StatefulWidget {
  static const String routeName = "/jp_test";
  static String title = "JP Test";

  @override
  _JPTestState createState() => _JPTestState();
}

class _JPTestState extends State<JPTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(JPTest.title),
      ),

      body: Container(
        color: JPRandomColor(),
        child: Center(
          child: Text("我是Flutter的", 
            style: TextStyle(color: JPRandomColor(), fontSize: 30),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.golf_course),
        onPressed: () {
          /**
           * 想 dismiss 回去 exts 不能用 {"params": {"present": true}}
           * FlutterBoost.singleton.closeCurrent(exts: {"params": {"present": true}});
           * 因为：
              Future<bool> closeCurrent(
                  {Map<String, dynamic> result, Map<String, dynamic> exts}) {
                BoostContainerSettings settings = containerManager?.onstageSettings;
                if (exts == null) {
                  exts = Map<String, dynamic>();
                }
                <<< 这里！！！尼玛 "params" 在这里会被覆盖！！！官方文档还叫我们用"params"作为参数Key，真是日他妹的！！！>>>
                exts["params"] = settings.params;
                if (!exts.containsKey("animated")) {
                  exts["animated"] = true;
                }
                return close(settings.uniqueId, result: result, exts: exts);
              }
           */
          FlutterBoost.singleton.closeCurrent(exts: {"present": true});
        },
      ),
    );
  }

  @override void dispose() {
    // TODO: implement dispose
    super.dispose();
    JPrint("JPTest 死了！");
  }
}