
import 'package:flutter/material.dart';
import 'package:jp_designcode/components/lists/course_sections_list.dart';

import '../constants.dart';

class CourseSectionsScreen extends StatelessWidget {
  const CourseSectionsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: kCardPopupBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft:  Radius.circular(34),
                bottomLeft: Radius.circular(34),
              ),
              boxShadow: [
                BoxShadow(
                  color: kShadowColor,
                  offset: Offset(0, 12),
                  blurRadius: 32,
                ),
              ],
            ),
            child: Column(
              // Column默认宽度为children中宽度最大的子组件的宽度
              // CrossAxisAlignment.stretch：使子控件填满交叉轴，因此Column宽度会填充为父组件的宽度
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Course Sections", style: kTitle2Style,),
                SizedBox(height: 5,),
                Text("12 sections", style: kSubtitleStyle,),
              ],
            ),
          ),
          CourseSectionList(),
          SizedBox(height: 32,),
        ],
      ),
    );
  }
}