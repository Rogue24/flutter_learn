import 'package:flutter/material.dart';

class JPProfileContent extends StatefulWidget {
  @override
  _JPProfileContentState createState() => _JPProfileContentState();
}

class _JPProfileContentState extends State<JPProfileContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("我的内容", style: TextStyle(fontSize: 30, color: Colors.green)),
    );
  }
}