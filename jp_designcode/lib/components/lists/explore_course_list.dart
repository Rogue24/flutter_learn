import 'package:flutter/material.dart';
import 'package:jp_designcode/components/cards/explore_course_card.dart';
import 'package:jp_designcode/model/course.dart';

class ExploreCourseList extends StatelessWidget {
  const ExploreCourseList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 水平滚动
        shrinkWrap: true, // 以子组件尺寸为准，自适应
        itemCount: exploreCourses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 20 : 0),
            child: ExploreCourseCard(course: exploreCourses[index]),
          );
        },
      ),
    );
  }
}