
import 'package:flutter/material.dart';
import 'package:jp_designcode/model/course.dart';

import '../../constants.dart';

class CourseSectionCard extends StatelessWidget {
  CourseSectionCard({required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(41),
          gradient: course.background,
          boxShadow: [
            BoxShadow(
              color: course.background.colors[0].withOpacity(0.3),
              blurRadius: 30,
              offset: Offset(0, 20),
            ),
            BoxShadow(
              color: course.background.colors[1].withOpacity(0.3),
              blurRadius: 30,
              offset: Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(41),
          child: Padding(
            padding: EdgeInsets.only(left: 32),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/illustrations/${course.illustration}",
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(course.courseSubtitle, style: kCardSubtitleStyle,),
                          SizedBox(height: 6,),
                          Text(course.courseTitle, style: kCardTitleStyle,),
                        ],
                      ),
                    ),
                    // 添加Spacer是为了将Expanded往左顶过去：Expanded是占据剩余空间，而Spacer是占据最大空间，因此这两个组件能实现对父组件空间的对半分。
                    Spacer(), 
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}