import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jp_designcode/model/course.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../constants.dart';
import 'course_sections_screen.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({required this.course});

  final Course course;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {

  Widget indicators() {
    List<Widget> indicators = [];

    for (var i = 0; i < 9; i++) {
      indicators.add(
        Container(
          width: 7,
          height: 7,
          // padding影响的是Container的child的外边距，而margin影响的是Container自身的外边距
          margin: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == 0 ? Color(0xFF0971FE) : Color(0xFFA6AEBD),
          ),
        )
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }

  late PanelController panelCtr;

  @override
  void initState() {
    super.initState();
    panelCtr = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kBackgroundColor,
        child: SlidingUpPanel(
          controller: panelCtr,
          backdropEnabled: true,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34),
          ),
          color: kCardPopupBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: kShadowColor,
              offset: Offset(0, -12),
              blurRadius: 32,
            )
          ],
          minHeight: 0, // 最小高度，也就是在父组件（这里是屏幕）底部露出来的那部分高度，0就是完全在父组件（这里是屏幕）外
          maxHeight: MediaQuery.of(context).size.height * 0.95,
          panel: CourseSectionsScreen(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(gradient: widget.course.background),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: SafeArea(
                        bottom: false, // 忽略底部的安全区域
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Hero(
                                        // tag值用于映射不同页面的组件，必须跟关联的组件保持一致且唯一
                                        tag: widget.course.logo, 
                                        child: Image.asset("assets/logos/${widget.course.logo}"),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Hero(
                                            // tag值用于映射不同页面的组件，必须跟关联的组件保持一致且唯一
                                            tag: widget.course.courseSubtitle, 
                                            child: Text(
                                              widget.course.courseSubtitle,
                                              // copyWith：拷贝一份新的然后修改其中的某个属性
                                              style: kSecondaryCalloutLabelStyle.copyWith(color: Colors.white70),
                                            ),
                                          ),
                                          Hero(
                                            // tag值用于映射不同页面的组件，必须跟关联的组件保持一致且唯一
                                            tag: widget.course.courseTitle, 
                                            child: Text(
                                              widget.course.courseTitle,
                                              // copyWith：拷贝一份新的然后修改其中的某个属性
                                              style: kLargeTitleStyle.copyWith(color: Colors.white,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: kPrimaryLabelColor.withOpacity(0.8),
                                        ),
                                        child: Icon(
                                          Icons.close, 
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 28,),
                              Expanded(
                                child: Hero(
                                  // tag值用于映射不同页面的组件，必须跟关联的组件保持一致且唯一
                                  tag: widget.course.illustration, 
                                  child: Image.asset(
                                    "assets/illustrations/${widget.course.illustration}",
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 28),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 12.5,
                          bottom: 13.5,
                          left: 20.5,
                          right: 14.5
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: kShadowColor,
                              blurRadius: 16,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        width: 60,
                        height: 60,
                        child: Image.asset("assets/icons/icon-play.png"),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    left: 28,
                    right: 28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container( // 包裹该Padding的Container大小为58
                            // Padding只会影响它的child的外边距，
                            // 如果Padding的父组件没有指定大小，假如它的child大小为20，则整个Padding大小为 4 + 20 + 4 = 28
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Container( // 该Container受外层Padding影响，因此大小为 58 - 8 = 50
                                padding: EdgeInsets.all(4),
                                child: CircleAvatar(
                                  child: Icon( // 该Icon受外层Container的padding影响，因此大小为 50 - 8 = 42
                                    Platform.isIOS ? CupertinoIcons.group_solid : Icons.people,
                                    color: Colors.white,
                                  ),
                                  radius: 21, // 42 / 2 = 21
                                  backgroundColor: kCourseElementIconColor,
                                ),
                                decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  borderRadius: BorderRadius.circular(25), // 50 / 2 = 25
                                ),
                              ),
                            ),
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                              gradient: widget.course.background,
                              borderRadius: BorderRadius.circular(29), // 58 / 2 = 25
                            ),
                          ),
                          SizedBox(width: 12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("39.8k", style: kTitle2Style,),
                              Text("Students", style: kSearchPlaceholderStyle,),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container( // 包裹该Padding的Container大小为58
                            // Padding只会影响它的child，自身（也就是父组件）的尺寸不会受影响
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Container( // 该Container受外层Padding影响，因此大小为 58 - 8 = 50
                                padding: EdgeInsets.all(4),
                                child: CircleAvatar(
                                  child: Icon( // 该Icon受外层Container的padding影响，因此大小为 50 - 8 = 42
                                    Platform.isIOS ? CupertinoIcons.news_solid : Icons.format_quote,
                                    color: Colors.white,
                                  ),
                                  radius: 21, // 42 / 2 = 21
                                  backgroundColor: kCourseElementIconColor,
                                ),
                                decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  borderRadius: BorderRadius.circular(25), // 50 / 2 = 25
                                ),
                              ),
                            ),
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                              gradient: widget.course.background,
                              borderRadius: BorderRadius.circular(29), // 58 / 2 = 25
                            ),
                          ),
                          SizedBox(width: 12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("25.4k", style: kTitle2Style,),
                              Text("Comments", style: kSearchPlaceholderStyle,),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      indicators(),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: kShadowColor,
                                offset: Offset(0, 12),
                                blurRadius: 16,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(14),
                          ),
                          width: 80,
                          height: 40,
                          child: Text("View all", style: kSearchTextStyle,),
                        ),
                        onTap: () {
                          panelCtr.open();
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "5 years ago, I couldn’t write a single line of Swift. I learned it and moved to React, Flutter while using increasingly complex design tools. I don’t regret learning them because SwiftUI takes all of their best concepts. It is hands-down the best way for designers to take a first step into code.",
                        style: kBodyLabelStyle,
                      ),
                      SizedBox(height: 24,),
                      Text("About this course", style: kTitle1Style,),
                      SizedBox(height: 24,),
                      Text(
                        "This course was written for people who are passionate about design and about Apple's SwiftUI. It beginner-friendly, but it is also packed with tricks and cool workflows about building the best UI. Currently, Xcode 11 is still in beta so the installation process may be a little hard. However, once you get everything working, then it'll get much friendlier!",
                        style: kBodyLabelStyle,
                      ),
                      SizedBox(height: 24,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}