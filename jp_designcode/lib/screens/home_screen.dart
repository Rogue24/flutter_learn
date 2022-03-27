import 'package:flutter/material.dart';
import 'package:jp_designcode/components/home_screen_navbar.dart';
import 'package:jp_designcode/components/lists/explore_course_list.dart';
import 'package:jp_designcode/components/lists/recent_course_list.dart';
import 'package:jp_designcode/screens/sidebar_screen.dart';

import '../JPLog.dart';
import '../constants.dart';
import 'continue_watching_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Animation<double> fadeAnim;
  late Animation<Offset> sidebarAnim;
  late AnimationController sidebarAnimCtr;

  var sidebarHidden = true;

  @override
  void initState() {
    super.initState();

    sidebarAnimCtr = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    sidebarAnim = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: sidebarAnimCtr, 
        curve: Curves.easeInOut
      ),
    );

    fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: sidebarAnimCtr, 
        curve: Curves.easeInOut
      ),
    );

    // 监听动画状态的改变
    sidebarAnim.addStatusListener((status) {
      JPrint("动画状态 --- $status");
    });
  }

  @override
  void dispose() {
    super.dispose();
    sidebarAnimCtr.dispose(); // 防止内存泄漏
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( // 在SafeArea外面就可以铺满整个屏幕
        color: kBackgroundColor,
        child: Stack(
          children: [
            // SafeArea：确保子组件不会超出安全区域
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HomeScreenNavBar(
                      triggerAnimation: (){
                        sidebarAnimCtr.forward();
                        setState(() => sidebarHidden = false);
                      },
                    ),
                    
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        // Column默认宽度为children中宽度最大的子组件的宽度
                        // CrossAxisAlignment.start：以Column宽度起始位置（左边）对齐
                        // CrossAxisAlignment.stretch：使子控件填满交叉轴，因此Column宽度会填充为父组件的宽度
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Recents",
                            style: kLargeTitleStyle,
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "23 courses, more coming",
                            style: kSubtitleStyle,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),

                    RecentCourseList(),

                    Padding(
                      padding: EdgeInsets.only(
                        top: 25,
                        left: 20,
                        bottom: 16,
                        right: 20
                      ),
                      child: Column(
                        // Column默认宽度为children中宽度最大的子组件的宽度
                        // CrossAxisAlignment.start：以Column宽度起始位置（左边）对齐
                        // CrossAxisAlignment.stretch：使子控件填满交叉轴，因此Column宽度会填充为父组件的宽度
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Explore",
                            style: kTitle1Style,
                          ),
                        ],
                      ),
                    ),

                    ExploreCourseList(),
                  ],
                ),
              ),
            ),

            ContinueWatchingScreen(),

            IgnorePointer(
              ignoring: sidebarHidden,
              child: Stack(
              children: [
                FadeTransition(
                  opacity: fadeAnim,
                  child: GestureDetector(
                    child: Container(
                    color: Color.fromRGBO(36, 38, 41, 0.4),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                    onTap: (){
                      sidebarAnimCtr.reverse();
                      setState(() => sidebarHidden = true);
                    },
                  ),
                ),

                SlideTransition(
                  position: sidebarAnim,
                  child: SafeArea(
                    child: SidebarScreen(),
                    bottom: false, // 忽略底部的安全区域
                  ),
                ),
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}

