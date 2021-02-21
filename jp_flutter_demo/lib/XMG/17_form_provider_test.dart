import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'package:jp_flutter_demo/widget_example/5_form_widget.dart';
import 'package:jp_flutter_demo/viewModel/form_viewModel.dart';
import 'package:provider/provider.dart';

class FormProviderExample extends StatelessWidget {
  static const String routeName = "/form_provider_demo";
  static String title = "Form + Provider";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          FormProviderExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      // ChangeNotifierProvider --- 只能全局使用，不能局部使用（猜的）
      // body: ChangeNotifierProvider(
      //   create: (BuildContext context) => JPFormViewModel(),
      //   child: Center(child: _FormProviderDemo())
      // ),

      body: Center(child: _FormProviderDemo()),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          Navigator.of(context).pushNamed(FormWidgetExample.routeName);
        },
      ),
      
    );
  }
}

class _FormProviderDemo extends StatefulWidget {
  @override
  __FormProviderDemoState createState() => __FormProviderDemoState();
}

class __FormProviderDemoState extends State<_FormProviderDemo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JPFormViewModel>(
      builder: (ctx, formVM, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("手机：${formVM.phone}", style: TextStyle(fontSize: 30, color: JPRandomColor())),
            Text("密码：${formVM.password}", style: TextStyle(fontSize: 30, color: JPRandomColor()))
          ],
        );
      }
    );
  }
}