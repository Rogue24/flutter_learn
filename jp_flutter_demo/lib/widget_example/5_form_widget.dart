import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'package:jp_flutter_demo/viewModel/form_viewModel.dart';
import 'package:provider/provider.dart';

/* 学自：https://juejin.cn/post/6844903954514444302 */

/* 
 * Form表单也是一个Widget，可以在里面放入我们的输入框。
 * 但是Form表单中输入框必须是FormField类型的
    * 我们查看刚刚学过的TextField是继承自StatefulWidget，并不是一个FormField类型；
    * 我们可以使用TextFormField，它的使用类似于TextField，并且是继承自FormField的；
 */

class FormWidgetExample extends StatelessWidget {
  static const String routeName = "/form_page_demo";
  static String title = "Form";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FormWidgetExample.title),
      ),
      backgroundColor: Colors.yellow,
      body: _MyForm(),
    );
  }
}

class _MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<_MyForm> {
  final _loginFormKey = GlobalKey<FormState>();
  String _phone, _password;

  // 点击按钮，调用 Form 的 State 对象的 save 方法，就会调用 Form 中放入的全部 TextFormField 的 onSave 回调
  // 问题是，怎么拿到 Form 的 State 对象 ？
  // ==> 绑定 GlobalKey，用一个属性保存这个 GlobalKey 可获取 Form 的 State
  void _goLogin() {
    _loginFormKey.currentState.save(); // 回调 ==> TextFormField 的 onSave 方法
    _loginFormKey.currentState.validate(); // 回调 ==> TextFormField 的 validator 方法

    JPrint("手机号：$_phone，密码：$_password");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey, // 绑定 GlobalKey

      child: Padding(
        padding: EdgeInsets.all(10),

        child: Selector<JPFormViewModel, JPFormViewModel>(
          selector: (ctx, formVM) => formVM,
          shouldRebuild: (oldVM, newVM) => false,
          
          builder: (ctx, formVM, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TextFormField(
                    initialValue: formVM.phone,
                    decoration:
                        InputDecoration(icon: Icon(Icons.people), labelText: "手机号"),
                    onSaved: (value) => _phone = value, // 当 Form 的 State 对象调用了 save 方法就会回调这里的代码
                    validator: (value) => value.isEmpty ? "手机号不能为空" : null,
                    // autovalidate: true, // 开启自动验证（该属性已过期）
                ),

                TextFormField(
                  initialValue: formVM.password,
                  obscureText: true, // 密码
                  decoration:
                      InputDecoration(icon: Icon(Icons.lock), labelText: "密码"),
                  onSaved: (value) => _password = value, // 当 Form 的 State 对象调用了 save 方法就会回调这里的代码
                  validator: (value) {
                    // 这里回调的是下方的警告文案
                    if (value.isEmpty) return "密码不能为空";
                    return null;
                  },
                ),

                SizedBox(height: 16,),

                Container(
                  width: double.infinity, // 无限大至父容器的宽度
                  height: 44,
                  child: RaisedButton(
                    color: Colors.lightGreen,
                    child: Text("登录", style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      // 保存文本框的值到属性上
                      _goLogin(); 
                      // 修改共享对象的属性值
                      formVM.phone = _phone;
                      formVM.password = _password;
                      // 回去
                      Navigator.of(context).pop();
                    },
                  ),
                ),

              ],
            );
          },
        ),
      )
    );

    // return Form(
    //   key: _loginFormKey, // 绑定 GlobalKey
    //   child: Padding(
    //     padding: EdgeInsets.all(10),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         TextFormField(
    //           initialValue: _phone,
    //           decoration:
    //               InputDecoration(icon: Icon(Icons.people), labelText: "手机号"),
    //           onSaved: (value) => _phone = value, // 当 Form 的 State 对象调用了 save 方法就会回调这里的代码
    //           validator: (value) => value.isEmpty ? "手机号不能为空" : null,
    //           // autovalidate: true, // 开启自动验证（该属性已过期）
    //         ),

    //         TextFormField(
    //           initialValue: _password,
    //           obscureText: true, // 密码
    //           decoration:
    //               InputDecoration(icon: Icon(Icons.lock), labelText: "密码"),
    //           onSaved: (value) => _password = value, // 当 Form 的 State 对象调用了 save 方法就会回调这里的代码
    //           validator: (value) {
    //             // 这里回调的是下方的警告文案
    //             if (value.isEmpty) return "密码不能为空";
    //             return null;
    //           },
    //         ),

    //         SizedBox(height: 16,),

    //         Container(
    //           width: double.infinity, // 无限大至父容器的宽度
    //           height: 44,
    //           child: RaisedButton(
    //             color: Colors.lightGreen,
    //             child: Text(
    //               "登录",
    //               style: TextStyle(fontSize: 20, color: Colors.white),
    //             ),
    //             onPressed: () => _goLogin(),
    //           ),
    //         )
    //       ],
    //     ),
    //   )
    // );
  }
}
