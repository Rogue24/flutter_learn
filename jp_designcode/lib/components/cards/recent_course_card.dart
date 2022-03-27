import 'package:flutter/material.dart';
import 'package:jp_designcode/model/course.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class RecentCourseCard extends StatelessWidget {
  RecentCourseCard(this.course);
  Course course;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              gradient: course.background,
              borderRadius: BorderRadius.circular(41),
              // 阴影效果是以数组形式是叠加上去的
              boxShadow: [
                BoxShadow(
                  color: course.background.colors[0].withOpacity(0.3), 
                  offset: Offset(0, 20),
                  blurRadius: 30,
                ),
                BoxShadow(
                  color: course.background.colors[1].withOpacity(0.3), 
                  offset: Offset(0, 20),
                  blurRadius: 30,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 32,
                    left: 32,
                    right: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        // tag值用于映射不同页面的组件，必须跟关联的组件保持一致且唯一
                        tag: course.courseSubtitle, 
                        child: Text(
                          course.courseSubtitle,
                          style: kCardSubtitleStyle,
                        ),
                      ),
                      SizedBox(height: 6,),
                      Hero(
                        // tag值用于映射不同页面的组件，必须跟关联的组件保持一致且唯一
                        tag: course.courseTitle, 
                        child: Text(
                          course.courseTitle,
                          style: kCardTitleStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded：让子组件填充剩余空间，确保子组件不会超出父组件区域
                Expanded(
                  child: Hero(
                    // tag值用于映射不同页面的组件，必须跟关联的组件保持一致且唯一
                    tag: course.illustration, 
                    child: Image.asset(
                      "assets/illustrations/${course.illustration}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )
          ),
        ),

        Padding(
          padding: EdgeInsets.only(right: 42),
          child: Container(
            child: Hero(
              // tag值用于映射不同页面的组件，必须跟关联的组件保持一致且唯一
              tag: course.logo, 
              child: Image.asset("assets/logos/${course.logo}"),
            ),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: kShadowColor, 
                  offset: Offset(0, 4),
                  blurRadius: 16,
                ),
              ],
            ),
            padding: EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}