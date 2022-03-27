import 'package:flutter/material.dart';
import 'package:jp_designcode/screens/profile_screen.dart';
import 'searchfield_widget.dart';
import 'sidebar_button.dart';

import '../constants.dart';

class HomeScreenNavBar extends StatelessWidget {
  const HomeScreenNavBar({required this.triggerAnimation});

  final void Function() triggerAnimation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SidebarButton(triggerAnimation: triggerAnimation),
          SearchFieldWidget(),
          Icon(
            Icons.notifications, 
            color: kPrimaryLabelColor
          ),
          SizedBox(width: 16,),
          GestureDetector(
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage("assets/images/profile.jpg"),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ProfileScreen();
                  },
                )
              );
            },
          )
        ],
      ),
    );
  }
}