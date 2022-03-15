import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/WHY/1_widget_element_render_tree.dart';
import 'package:jp_flutter_demo/WHY/2_widget_key.dart';
import 'package:jp_flutter_demo/WHY/3_GlobalKey.dart';
import 'package:jp_flutter_demo/WHY/4_InheritedWidget.dart';
import 'package:jp_flutter_demo/WHY/5_provider.dart';
import 'package:jp_flutter_demo/WHY/6_pointer_event.dart';
import 'package:jp_flutter_demo/WHY/7_gesture.dart';
import 'package:jp_flutter_demo/WHY/8_event_bus.dart';
import 'package:jp_flutter_demo/WHY/9_MaterialPageRoute.dart';
import 'package:jp_flutter_demo/WHY/10_named_route.dart';
import 'package:jp_flutter_demo/WHY/11_animation_basic.dart';
import 'package:jp_flutter_demo/WHY/12_AnimatedWidget.dart';
import 'package:jp_flutter_demo/WHY/13_AnimatedBuilder.dart';
import 'package:jp_flutter_demo/WHY/14_animation_interweave.dart';
import 'package:jp_flutter_demo/WHY/15_animation_transition.dart';
import 'package:jp_flutter_demo/WHY/16_animation_hero.dart';
import 'package:jp_flutter_demo/WHY/17_form_provider_test.dart';
import 'package:jp_flutter_demo/WHY/18_theme_basic.dart';
import 'package:jp_flutter_demo/WHY/19_theme_dark_fit.dart';
import 'package:jp_flutter_demo/WHY/20_screen_fit.dart';
import 'package:jp_flutter_demo/WHY/21_image_picker.dart';
import 'package:jp_flutter_demo/WHY/22_method_channel.dart';

class WHYClass extends StatelessWidget {
  static String title = "WHY Class";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WHYClass.title),
      ),
      body: _WHYClassList(),
    );
  }
}

class _WHYClassList extends StatefulWidget {
  // 貌似使用 StatelessWidget 无法路由
  @override
  createState() => _WHYClassListState();
}

class _WHYClassListState extends State<_WHYClassList> {
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