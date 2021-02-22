import 'package:flutter/material.dart';
import 'dart:math';

// 随机颜色
// ignore: non_constant_identifier_names
Color JPRandomColor({double a = 1}) {
  return Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), a);
  // return Color.fromARGB((255.0 * a).toInt(), Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
}

// ignore: non_constant_identifier_names
void JPPush({@required Widget widget, @required BuildContext context, bool isFullscreenDialog = false}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
      fullscreenDialog: isFullscreenDialog
    )
  );
}

// ignore: non_constant_identifier_names
void JPPushNamed({@required String routeName, @required BuildContext context}) {
  Navigator.of(context).pushNamed(routeName);
}

// ignore: non_constant_identifier_names
void JPPop({@required BuildContext context, Object result}) {
  if (result == null) {
    Navigator.of(context).pop();
    return;
  }
  Navigator.of(context).pop(result);
}

// 自定义日志打印
// ignore: non_constant_identifier_names
void JPrint(Object message) {
  if (_inProduction) return;
  StackTrace current = StackTrace.current;
  _CustomTrace programInfo = _CustomTrace(current);
  print("[${programInfo.fileName}] 第${programInfo.lineNumber}行: $message");
}

class _CustomTrace {
  final StackTrace _trace;

  String fileName;
  int lineNumber;
  int columnNumber;

  _CustomTrace(this._trace) {
    _parseTrace();
  }

  void _parseTrace() {
    // 0 是栈顶，也就是当前此处的文件的信息，这里要获取的是上一个文件的信息（调用函数的地方），所以是下一个
    var traceString = this._trace.toString().split("\n")[1]; 
    var indexOfFileName = traceString.indexOf(RegExp(r'[0-9*A-Za-z_]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    var listOfInfos = fileInfo.split(":");
    this.fileName = listOfInfos[0];
    this.lineNumber = int.parse(listOfInfos[1]);
    var columnStr = listOfInfos[2];
    columnStr = columnStr.replaceFirst(")", "");
    this.columnNumber = int.parse(columnStr);
  }
}

/* 
 * 是否生产环境（还没验证）
 * 当 App 运行在 Release 环境时，inProduction 为 true；
 * 当 App 运行在 Debug 或 Profile 环境时，inProduction 为 false。
 */
const bool _inProduction = const bool.fromEnvironment("dart.vm.product");
