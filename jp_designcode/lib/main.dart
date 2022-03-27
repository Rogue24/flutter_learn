import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // 初始化屏幕信息
    // JPSizeFit.initialize(() {});
    // JPrint("----- MyApp -----");
    // final mediaQueryData = MediaQuery.of(context);
    // final screenWidth = mediaQueryData.size.width;
    // final screenHeight = mediaQueryData.size.height;
    // JPrint("screenWidth：$screenWidth");
    // JPrint("screenHeight：$screenHeight");
    // JPrint("----- MyApp -----");

    return MaterialApp(
      debugShowCheckedModeBanner: false, // 隐藏右上角Debug的标识图标
      home: HomeScreen(),
    );
  }
}