import 'package:flutter/material.dart';
import 'package:jp_designcode/components/cards/recent_course_card.dart';
import 'package:jp_designcode/model/course.dart';
import 'package:jp_designcode/screens/course_screen.dart';

class RecentCourseList extends StatefulWidget {
  const RecentCourseList({ Key? key }) : super(key: key);

  @override
  State<RecentCourseList> createState() => _RecentCourseListState();
}

class _RecentCourseListState extends State<RecentCourseList> {

  List<Container> indicators = [];
  int currentPage = 0;

  Widget updateIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: recentCourses.map((course) {
        var index = recentCourses.indexOf(course);
        return Container(
          width: 7,
          height: 7,
          margin: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index ? Color(0xFF0971FE) : Color(0xFFA6AEBD),
          ),
        );
      }).toList(),
    );
  }

 // 宽度系数：这里宽度为无限大，最大也就是父组件的宽度，意思为 宽度 = 父组件宽度 x 系数
 double viewportFraction() {
   final width = MediaQuery.of(context).size.width;
   var fraction = 1 - (width - 240) / width;
   return fraction + 0.05;
 }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 320,
          width: double.infinity,
          child: PageView.builder(
            itemCount: recentCourses.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Opacity(
                  opacity: currentPage == index ? 1 : 0.5, 
                  child: RecentCourseCard(
                    recentCourses[index]
                  ),
                ),
                onTap: () {
                  if (currentPage != index) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseScreen(course: recentCourses[index]),
                      fullscreenDialog: true, // Moda模式推出，false为push（默认push）
                    ),
                  );
                },
              );
            },
            
            controller: PageController(
              initialPage: 0, 
              // 这里宽度为无限大，最大也就是父组件的宽度，意思为【宽度 = 父组件宽度 x 系数】
              viewportFraction: viewportFraction(), // 0.63, 
            ),
            
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
          ),
        ),

        updateIndicators(),
      ],
    );
  }
}