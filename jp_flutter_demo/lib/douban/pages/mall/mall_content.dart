import 'package:flutter/material.dart';

class JPMallContent extends StatefulWidget {
  @override
  _JPMallContentState createState() => _JPMallContentState();
}

class _JPMallContentState extends State<JPMallContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("市集内容", style: TextStyle(fontSize: 30, color: Colors.green)),
    );
  }
}