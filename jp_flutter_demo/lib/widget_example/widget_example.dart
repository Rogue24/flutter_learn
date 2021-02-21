import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/widget_example/1_text_widget.dart';
import 'package:jp_flutter_demo/widget_example/2_button_widget.dart';
import 'package:jp_flutter_demo/widget_example/3_image_widget.dart';
import 'package:jp_flutter_demo/widget_example/4_textField_widget.dart';
import 'package:jp_flutter_demo/widget_example/5_form_widget.dart';
import 'package:jp_flutter_demo/widget_example/6_child_widget.dart';
import 'package:jp_flutter_demo/widget_example/7_children_widget.dart';
import 'package:jp_flutter_demo/widget_example/8_list_widget.dart';
import 'package:jp_flutter_demo/widget_example/9_grid_widget.dart';
import 'package:jp_flutter_demo/widget_example/10_slivers_widget.dart';
import 'package:jp_flutter_demo/widget_example/11_scroll_listener.dart';
import 'package:jp_flutter_demo/widget_example/12_jp_widget.dart';

class WidgetExample extends StatelessWidget {
  static String title = "Widget Example";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WidgetExample.title),
      ),
      body: _WidgetExampleList(),
    );
  }
}

class _WidgetExampleList extends StatefulWidget {
  // 貌似使用 StatelessWidget 无法路由
  @override
  createState() => _WidgetExampleListState();
}

class _WidgetExampleListState extends State<_WidgetExampleList> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

        ListTile(
          title: Text(
            TextWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(TextWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            ButtonWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(ButtonWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            ImageWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(ImageWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            TextFieldWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(TextFieldWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            FormWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(FormWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            ChildWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(ChildWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            ChildrenWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(ChildrenWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            ListWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(ListWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            GirdWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(GirdWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            SliversWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(SliversWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            ScrollListenerExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(ScrollListenerExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            JPWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(JPWidgetExample());
          },
        ),

      ],
    );
  }

  void _push(Widget widget) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
      ),
    );
  }
}