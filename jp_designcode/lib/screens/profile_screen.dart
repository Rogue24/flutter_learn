import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jp_designcode/components/certificate_viewer.dart';
import 'package:jp_designcode/components/lists/completed_courses_list.dart';
import 'package:jp_designcode/constants.dart';

class ProfileScreen extends StatelessWidget {

  final List<String> badges = [
    "badge-01.png",
    "badge-02.png",
    "badge-03.png",
    "badge-04.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: kCardPopupBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(34)
                ),
                boxShadow: [
                  BoxShadow(
                    color: kShadowColor,
                    offset: Offset(0, 12),
                    blurRadius: 32,
                  ),
                ]
              ),
              child: SafeArea(
                bottom: false, // 忽略底部的安全区域
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 24,
                        bottom: 32, 
                        left: 20, 
                        right: 20
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RawMaterialButton(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            constraints: BoxConstraints(
                              minWidth: 40,
                              maxWidth: 40,
                              maxHeight: 24,
                            ),
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.arrow_back, 
                                  color: kSecondaryLabelColor,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Profile", 
                            style: kCalloutLabelStyle,
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: kShadowColor,
                                  offset: Offset(0, 12),
                                  blurRadius: 32,
                                ),
                              ],
                            ),
                            child: Icon(
                              Platform.isIOS ? CupertinoIcons.settings_solid : Icons.settings,
                              color: kSecondaryLabelColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: Container( // 84 - 12 = 72 
                                padding: EdgeInsets.all(6),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/profile.jpg"),
                                  radius: 30,
                                ),
                                decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  // 只要不低于36，就能保证是圆（超出不会裁剪）
                                  borderRadius: BorderRadius.circular(36), 
                                ),
                              ),
                            ),
                            height: 84,
                            width: 84,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  Color(0xFF00AEFF),
                                  Color(0xFF0076FF),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(42),
                            ),
                          ),
                          SizedBox(width: 16,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Rogue24", style: kTitle2Style,),
                              SizedBox(height: 8,),
                              Text("iOS & Flutter Developer", style: kSecondaryCalloutLabelStyle,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 28, bottom: 16),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Badges", style: kHeadlineLabelStyle,),
                                Row(
                                  children: [
                                    Text("See all", style: kSearchPlaceholderStyle,),
                                    Icon(Icons.chevron_right, color: kSecondaryLabelColor,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    Container(
                      height: 112,
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 28),
                        scrollDirection: Axis.horizontal,
                        itemCount: badges.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                              left: 20, 
                              right: index == (badges.length - 1) ? 20 : 0
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: kShadowColor.withOpacity(0.1),
                                  offset: Offset(0, 12),
                                  blurRadius: 18,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "assets/badges/${badges[index]}"
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 32,
                left: 20,
                right: 20,
                bottom: 12,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Certificates",
                        style: kHeadlineLabelStyle,
                      ),
                      Row(
                        children: [
                          Text(
                            "See all", 
                            style: kSearchPlaceholderStyle,
                          ),
                          Icon(
                            Icons.chevron_right, 
                            color: kSecondaryLabelColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CertificateViewer(),

            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 12,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Completed Courses",
                        style: kHeadlineLabelStyle,
                      ),
                      Row(
                        children: [
                          Text(
                            "See all", 
                            style: kSearchPlaceholderStyle,
                          ),
                          Icon(
                            Icons.chevron_right, 
                            color: kSecondaryLabelColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CompletedCoursesList(),

            SizedBox(height: 28,),
          ],
        ),
      ),
    );
  }
}