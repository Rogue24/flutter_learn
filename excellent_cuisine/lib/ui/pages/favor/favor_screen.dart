import 'package:flutter/material.dart';

import 'favor_content.dart';

class JPFavorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏"),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      body: JPFavorContent(),
    );
  }
}