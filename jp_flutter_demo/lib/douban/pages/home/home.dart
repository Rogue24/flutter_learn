import 'package:flutter/material.dart';
import 'home_content.dart';

class JPHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页", style: TextStyle(color: Colors.white))
      ),
      body: JPHomeContent(),
    );
  }
}
