import 'package:flutter/material.dart';

class JPSubjectContent extends StatefulWidget {
  @override
  _JPSubjectContentState createState() => _JPSubjectContentState();
}

class _JPSubjectContentState extends State<JPSubjectContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("书影音内容", style: TextStyle(fontSize: 30, color: Colors.green)),
    );
  }
}