import 'package:flutter/material.dart';
import 'package:jp_designcode/constants.dart';
import 'package:jp_designcode/model/sidebar.dart';

class SidebarRow extends StatelessWidget {
  final SidebarItem item;

  SidebarRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: item.background,
          ),
          child: item.icon,
        ),
        
        SizedBox(width: 12,),
        
        Container(
          child: Text(
            item.title,
            style: kCalloutLabelStyle,
          ),
        )
      ],
    );
  }
}