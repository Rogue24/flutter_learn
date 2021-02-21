import 'package:flutter/material.dart';
import 'mall_content.dart';

class JPMallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("市集", style: TextStyle(color: Colors.white))
      ),
      body: JPMallContent(),
    );
  }
}