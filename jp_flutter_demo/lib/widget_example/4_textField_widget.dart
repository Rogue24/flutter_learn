import 'package:flutter/material.dart';

/* 学自：https://juejin.cn/post/6844903954514444302 */

class TextFieldWidgetExample extends StatelessWidget {
  static String title = "4.TextField";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextFieldWidgetExample.title),
      ),
      backgroundColor: Colors.brown,
      body: _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [MyTextField()],
      ),
    );
  }
}

// TextField 是有状态的，用 StatefulWidget
class MyTextField extends StatefulWidget {
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  /*
   * keyboardType键盘的类型，
   * style设置样式，
   * textAlign文本对齐方式，
   * maxLength最大显示行数等等；
   * decoration：用于设置输入框相关的样式
     * icon：设置左边显示的图标
     * labelText：在输入框上面显示一个提示的文本
     * hintText：显示提示的占位文字
     * border：输入框的边框，默认底部有一个边框，可以通过InputBorder.none删除掉
     * filled：是否填充输入框，默认为false
     * fillColor：输入框填充的颜色
   * onChanged：监听输入框内容的改变，传入一个回调函数
   * onSubmitted：点击键盘中右下角的down时，会回调的一个函数
   * controller：用于控制、监听textField
   */

  // 如果没有为 TextField 提供一个 Controller，那么 TextField 会默认创建一个 TextEditingController
  // 自己来创建一个 Controller，覆盖 TextField 默认的
  final textEditingCtr = TextEditingController();

  @override
  void initState() {
    super.initState();

    // 使用自己创建的 Controller 来初始化一些默认值
    textEditingCtr.text = "Love You";

    // 监听
    textEditingCtr.addListener(() => print("Controller --- ${textEditingCtr.text}"));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          icon: Icon(Icons.people),
          labelText: "用户名",
          hintText: "请输入用户名",
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.yellowAccent
      ),
      controller: textEditingCtr, // 使用自己创建的控制器
      onChanged: (value) => print("编辑ing --- $value"),
      onSubmitted: (value) => print("编辑done --- $value"),
    );
  }
}
