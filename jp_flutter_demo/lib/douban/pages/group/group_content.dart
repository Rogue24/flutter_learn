import 'package:flutter/material.dart';

class JPGroupContent extends StatefulWidget {
  @override
  _JPGroupContentState createState() => _JPGroupContentState();
}

class _JPGroupContentState extends State<JPGroupContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("小组内容", style: TextStyle(fontSize: 30, color: Colors.green)),
    );
  }
}