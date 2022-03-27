import 'package:flutter/material.dart';
import 'package:jp_designcode/components/sidebar_row.dart';
import 'package:jp_designcode/model/sidebar.dart';

import '../constants.dart';

class SidebarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSidebarBackgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(34),
        ),
      ),
      
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height,

      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 35,
      ),

      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile.jpg"),
                  radius: 21,
                ),

                SizedBox(width: 15,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
                  children: [
                    Text(
                      "Rogue24",
                      style: kHeadlineLabelStyle,
                    ),

                    SizedBox(height: 4,),

                    Text(
                      "License ends on 1 Oct, 2049",
                      style: kSearchPlaceholderStyle,
                    ),
                  ],
                )
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.08,),

            SidebarRow(item: sidebarItems[0]),
            SizedBox(height: 32,),

            SidebarRow(item: sidebarItems[1]),
            SizedBox(height: 32,),

            SidebarRow(item: sidebarItems[2]),
            SizedBox(height: 32,),

            SidebarRow(item: sidebarItems[3]),
            Spacer(),

            Row(
              children: [
                Image.asset("assets/icons/icon-logout.png", width: 17,),
                SizedBox(width: 12,),
                Text("Log out", style: kSecondaryCalloutLabelStyle,),
              ],
            )
          ],
        ),
      ),
    );
  }
}