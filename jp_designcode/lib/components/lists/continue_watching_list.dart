import 'package:flutter/material.dart';
import 'package:jp_designcode/components/cards/continue_watching_card.dart';
import 'package:jp_designcode/model/course.dart';

class ContinueWatchingList extends StatefulWidget {
  const ContinueWatchingList({ Key? key }) : super(key: key);

  @override
  State<ContinueWatchingList> createState() => _ContinueWatchingListState();
}

class _ContinueWatchingListState extends State<ContinueWatchingList> {
  List<Container> indicators = [];
  int currentPage = 0;

  Widget updateIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: continueWatchingCourses.map((course) {
        var index = continueWatchingCourses.indexOf(course);
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          child: PageView.builder(
            itemBuilder: (context, index) {
              return Opacity(
                opacity: currentPage == index ? 1 : 0.5,
                child: ContinueWatchingCard(continueWatchingCourses[index]),
              );
            },
            itemCount: continueWatchingCourses.length,

            controller: PageController(
              initialPage: 0, 
              // 这里宽度为无限大，最大也就是父组件的宽度，意思为【宽度 = 父组件宽度 x 系数】
              viewportFraction: 0.75, 
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