import 'dart:math';

import 'package:flutter/material.dart';

class CertificateViewer extends StatefulWidget {
  const CertificateViewer({ Key? key }) : super(key: key);

  @override
  State<CertificateViewer> createState() => _CertificateViewerState();
}

class _CertificateViewerState extends State<CertificateViewer> {

  final List<String> certificatePaths = [
    "assets/certificates/certificate-01.png",
    "assets/certificates/certificate-02.png",
    "assets/certificates/certificate-03.png",
  ];

  late Widget certificateViewer;

  @override
  void initState() {
    super.initState();

    List<Widget> imageChildren = [];

    // reversed 倒序
    // toList 转数组
    // asMap 转字典
    // forEach 遍历字典
    certificatePaths.reversed.toList().asMap().forEach((index, certificate) {
      int angleDegree;
      if (index == certificatePaths.length - 1) {
        angleDegree = 0;
      } else {
        // Random().nextInt(xx) <xx>以内的随机数
        angleDegree = Random().nextInt(10) - 5;
      }

      imageChildren.add(
        Transform.rotate(
          angle: angleDegree * (pi / 180),
          child: Image.asset(
            certificate, 
            alignment: Alignment.center, 
            fit: BoxFit.cover,
          ),
        ),
      );
    });

    certificateViewer = Stack(
      children: imageChildren,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: certificateViewer,
    );
  }
}