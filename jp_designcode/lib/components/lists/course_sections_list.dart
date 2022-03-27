
import 'package:flutter/material.dart';
import 'package:jp_designcode/components/cards/course_sections_card.dart';
import 'package:jp_designcode/model/course.dart';

import '../../constants.dart';

class CourseSectionList extends StatelessWidget {
  const CourseSectionList({ Key? key }) : super(key: key);

  List<Widget> courseSectionsWidgets() {
    List<Widget> cards = [];

    for (var course in courseSections) {
      cards.add(
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: CourseSectionCard(course: course),
        )
      );
    }

    cards.add(
      Padding(
        padding: EdgeInsets.only(top: 12),
        child: Text(
          "No more Sections to view,\nlook for more in our courses",
          style: kCaptionLabelStyle,
          textAlign: TextAlign.center
        ),
      )
    );
    
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        // ListView默认自带上下边距，大概47
        // padding: EdgeInsets.symmetric(vertical: 47), 
        children: courseSectionsWidgets(),
      ),
    );
  }
}