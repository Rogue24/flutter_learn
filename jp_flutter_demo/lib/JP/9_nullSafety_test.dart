import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

class JPNullSafetyTestViewExample extends StatelessWidget {
  static String title = "9.Null Safety Example";

  final GlobalKey<_JPNullSafetyDemoState> gbKey = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPNullSafetyTestViewExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: JPNullSafetyDemo(gbKey),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.show_chart_sharp),
        onPressed: () {
          var state = gbKey.currentState;
          state?.doSomeThing();
        },
      ),
      
    );
  }
}

class JPNullSafetyDemo extends StatefulWidget {
  JPNullSafetyDemo(Key key) : super(key: key);

  @override
  _JPNullSafetyDemoState createState() => _JPNullSafetyDemoState();
}

class _JPNullSafetyDemoState extends State<JPNullSafetyDemo> {

  int count = 0;

  String? getText(){
    if(count % 2 == 0){
      return "$count";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(getText() ?? "空的", style: TextStyle(fontSize: 30, color: JPRandomColor())),
    );
  }

  void doSomeThing() {
    setState(() {
      count += 1;
      print(count);
    });
  }
}