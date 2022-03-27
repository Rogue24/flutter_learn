import 'package:flutter/material.dart';
import 'package:jp_designcode/components/certificate_viewer.dart';
import 'package:jp_designcode/components/lists/continue_watching_list.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../constants.dart';

class ContinueWatchingScreen extends StatelessWidget {
  const ContinueWatchingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      backdropEnabled: true,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(34),
      ),
      color: kCardPopupBackgroundColor,
      boxShadow: [
        BoxShadow(
          color: kShadowColor,
         offset: Offset(0, -12),
          blurRadius: 32
        ),
      ],
      minHeight: 85,
      maxHeight: MediaQuery.of(context).size.height * 0.75,
      panel: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 提示可拖拽的线
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 12, bottom: 16),
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Color(0xFFC5CBD6),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              "Continue Watching",
              style: kTitle2Style,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: ContinueWatchingList(),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              "Certificates",
              style: kTitle2Style,
            ),
          ),

          // Stack内部如果没有指定尺寸的子组件，则默认是无限量的高度，有的话就以子组件中最大尺寸的那个
          // 这里使用Expanded确保Stack不会超出父组件区域的同时如果子组件不够大也能填充剩余空间
          Expanded(
            child: CertificateViewer(),
          ),
        ],
      ),
    );
  }
}