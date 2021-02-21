import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/XMG/1_widget_element_render_tree.dart';
import 'package:jp_flutter_demo/XMG/2_widget_key.dart';
import 'package:jp_flutter_demo/XMG/3_GlobalKey.dart';
import 'package:jp_flutter_demo/XMG/4_InheritedWidget.dart';
import 'package:jp_flutter_demo/XMG/5_provider.dart';
import 'package:jp_flutter_demo/XMG/6_pointer_event.dart';
import 'package:jp_flutter_demo/XMG/7_gesture.dart';
import 'package:jp_flutter_demo/XMG/8_event_bus.dart';
import 'package:jp_flutter_demo/XMG/9_MaterialPageRoute.dart';
import 'package:jp_flutter_demo/XMG/10_named_route.dart';
import 'package:jp_flutter_demo/XMG/11_animation_basic.dart';
import 'package:jp_flutter_demo/XMG/12_AnimatedWidget.dart';
import 'package:jp_flutter_demo/XMG/13_AnimatedBuilder.dart';
import 'package:jp_flutter_demo/XMG/14_animation_interweave.dart';
import 'package:jp_flutter_demo/XMG/15_animation_transition.dart';
import 'package:jp_flutter_demo/XMG/16_animation_hero.dart';
import 'package:jp_flutter_demo/XMG/17_form_provider_test.dart';
import 'package:jp_flutter_demo/XMG/18_theme_basic.dart';
import 'package:jp_flutter_demo/XMG/19_theme_dark_fit.dart';
import 'package:jp_flutter_demo/XMG/20_screen_fit.dart';
import 'package:jp_flutter_demo/XMG/21_image_picker.dart';
import 'package:jp_flutter_demo/XMG/22_method_channel.dart';

class XMGClass extends StatelessWidget {
  static String title = "XMG Class";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(XMGClass.title),
      ),
      body: _XMGClassList(),
    );
  }
}

class _XMGClassList extends StatefulWidget {
  // 貌似使用 StatelessWidget 无法路由
  @override
  createState() => _XMGClassListState();
}

class _XMGClassListState extends State<_XMGClassList> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        
        ListTile(
          title: Text(
            TreeExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(TreeExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            WidgetKeyExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(WidgetKeyExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            GlobalKeyExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(GlobalKeyExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            InheritedWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(InheritedWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            ProviderExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(ProviderExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            PointerEventExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(PointerEventExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            GestureExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(GestureExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            EventBusExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(EventBusExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            MaterialPageRouteExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(MaterialPageRouteExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            NamedRouteExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(NamedRouteExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            AnimationBasicExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(AnimationBasicExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            AnimatedWidgetExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(AnimatedWidgetExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            AnimatedBuilderExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(AnimatedBuilderExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            AnimatedInterweaveExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(AnimatedInterweaveExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            AnimationTransitionExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(AnimationTransitionExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            AnimationHeroExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(AnimationHeroExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            FormProviderExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(FormProviderExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            GlobalThemeExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(GlobalThemeExample(), isFullscreenDialog: true);
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            DartThemeExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(DartThemeExample(), isFullscreenDialog: true);
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            ScreenFitExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(ScreenFitExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            ImagePickerExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(ImagePickerExample());
          },
        ),

        Divider(),
        ListTile(
          title: Text(
            MethodChannelExample.title,
            style: _biggerFont,
          ),
          onTap: () {
            _push(MethodChannelExample());
          },
        ),

      ],
    );
  }

  void _push(Widget widget, {bool isFullscreenDialog = false}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => widget,
        fullscreenDialog: isFullscreenDialog
      )
    );
  }
}