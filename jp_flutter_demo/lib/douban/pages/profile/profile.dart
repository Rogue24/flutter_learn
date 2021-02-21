import 'package:flutter/material.dart';
import 'profile_content.dart';

class JPProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的", style: TextStyle(color: Colors.white))
      ),
      body: JPProfileContent(),
    );
  }
}