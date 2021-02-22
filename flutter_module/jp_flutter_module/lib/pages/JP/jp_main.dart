import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:jp_flutter_module/pages/JP/jp_demo.dart';
import 'package:jp_flutter_module/shared/JPLog.dart';
import 'package:jp_flutter_module/view_model/ios_message_view_model.dart';
import 'package:provider/provider.dart';

class JPMainPage extends StatelessWidget {
  static const String routeName = "/jp_main";
  
  final GlobalKey<__TestTextState> _invokeTtKey = GlobalKey();

  final GlobalKey<__TestTextState> _flutterPresentTtKey = GlobalKey();
  final GlobalKey<__TestTextState> _flutterPushTtKey = GlobalKey();
  final GlobalKey<__TestTextState> _iosPresentTtKey = GlobalKey();
  final GlobalKey<__TestTextState> _iosPushTtKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    // 路由参数
    final BoostContainerSettings settings = BoostContainer.of(context).settings;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello Flutter"),
      ),

      backgroundColor: JPRandomColor(),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${settings.name}",
              style: TextStyle(color: JPRandomColor(), fontSize: 25),
            ),

            SizedBox(height: 8,),
            Text(
              "${settings.params["jp_param"]}",
              style: TextStyle(color: JPRandomColor(), fontSize: 15),
            ),

            SizedBox(height: 8,),
            Consumer<JPMessageViewModel>(
              builder: (ctx, msgVM, child) {
                return Text(
                  msgVM.message.length > 0 ? "${msgVM.message}" : "点击纸飞机发送消息，然后接收 sendEvent",
                  style: TextStyle(color: JPRandomColor(), fontSize: 20),
                );
              },
            ),

            SizedBox(height: 8,),
            _TestText("点击信息图标获取屏幕尺寸 invokeMethod", key: _invokeTtKey),

            SizedBox(height: 8,),
            RaisedButton(
              child: Text("present JPDemo"),
              onPressed: () {
                FlutterBoost.singleton.open(JPDemo.routeName, urlParams: {"present": true, "jp_param": "从 jp_main - modal 过来的"}).then((value) {
                  JPrint("--------- Flutter 返回 dismiss --------");
                  _flutterPresentTtKey.currentState.updateText("Flutter dismiss --- $value");
                });
              },
            ),
            _TestText("监听 Flutter dismiss 返回的信息", key: _flutterPresentTtKey),

            SizedBox(height: 8,),
            RaisedButton(
              child: Text("push JPDemo"),
              onPressed: () {
                FlutterBoost.singleton.open(JPDemo.routeName, urlParams: {"jp_param": "从 jp_main - push 过来的"}).then((value) {
                  JPrint("--------- Flutter 返回 pop --------");
                  _flutterPushTtKey.currentState.updateText("Flutter pop --- $value");
                });
              },
            ),
            _TestText("监听 Flutter pop 返回的信息", key: _flutterPushTtKey),

            SizedBox(height: 8,),
            RaisedButton(
              child: Text("model 原生页面 JPViewController"),
              onPressed: () {
                FlutterBoost.singleton.open("native", urlParams: {"present": true, "nativePageName": "JPViewController", "jp_param": "从 jp_main - modal 过来的"}).then((value) {
                  JPrint("--------- 原生 返回 dismiss --------");
                  _iosPresentTtKey.currentState.updateText("原生 dismiss --- $value");
                });
              },
            ),
            _TestText("监听 原生 dismiss 返回的信息", key: _iosPresentTtKey),

            SizedBox(height: 8,),
            RaisedButton(
              child: Text("push 原生页面 JPViewController"),
              onPressed: () {
                FlutterBoost.singleton.open("native", urlParams: {"nativePageName": "JPViewController", "jp_param": "从 jp_main - push 过来的"}).then((value) {
                  JPrint("--------- 原生 返回 pop --------");
                  _iosPushTtKey.currentState.updateText("原生 pop --- $value");
                });
              },
            ),
            _TestText("监听 原生 pop 返回的信息", key: _iosPushTtKey),

          ],
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          
          SizedBox(height: 8,),
          FloatingActionButton(
            heroTag: 3,
            child: Icon(Icons.send),
            onPressed: () {
              FlutterBoost.singleton.channel.sendEvent("event_sendFrom_flutter", {"message": "Flutter -> iOS -> Flutter"});
            },
          ),

          SizedBox(height: 8,),
          FloatingActionButton(
            heroTag: 4,
            child: Icon(Icons.message),
            onPressed: () => _invokeTtKey.currentState.getScreenInfo(),
          ),

          SizedBox(height: 8,),
          FloatingActionButton(
            heroTag: 5,
            child: Icon(Icons.close),
            onPressed: () {
              // FlutterBoost.singleton.close(settings.uniqueId);
              FlutterBoost.singleton.closeCurrent(result: {"jp_param": "从 jp_main 回来的"});
            },
          ),

        ],
      ), 
    );
  }
}

class _TestText extends StatefulWidget {
  final String _firstText;
  _TestText(this._firstText, {Key key}) : super(key: key);
  
  @override
  __TestTextState createState() => __TestTextState();
}

class __TestTextState extends State<_TestText> {
  MethodChannel _methodChannel = MethodChannel('zhoujianping.com/screen_info');
  
  String _text;

  @override
  Widget build(BuildContext context) {
    return Container( 
      child: Text(
        _text == null ? widget._firstText : _text,
        style: TextStyle(color: JPRandomColor(), fontSize: 20),
      ),
    );
  }

  void updateText(String text) {
    setState(() => _text = text);
  }

  void getScreenInfo() async {
    try {
      final Map result = await _methodChannel.invokeMethod("getScreenInfo");
      JPrint("调用iOS方法✅  getScreenInfo --- $result");
      updateText("scale: ${result["screen_scale"]}, width: ${result["screen_width"]}, height: ${result["screen_height"]}");
    } catch(error) {
      if (error is PlatformException) {
        PlatformException exc = error;
        JPrint("调用iOS方法❌  getScreenInfo --- ${exc.message}");
        updateText(exc.message);
      } else {
        JPrint("调用iOS方法❌（不是PlatformException）getScreenInfo --- $error");
        updateText(error.toString());
      }
    }
  }
}