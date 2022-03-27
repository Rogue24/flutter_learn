import 'package:flutter/material.dart';

import '../constants.dart';

class SidebarButton extends StatelessWidget {
  const SidebarButton({required this.triggerAnimation});

  final void Function() triggerAnimation;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      // MaterialTapTargetSize：用于设置点击区域
      // 1.padded：最小点击区域为48*48
      // 2.shrinkWrap：点击区域为子组件的实际大小
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      constraints: BoxConstraints(
        maxWidth: 40,
        maxHeight: 40,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: kShadowColor,
              offset: Offset(0, 12),
              blurRadius: 16,
            ),
          ],
        ),
        child: Image.asset(
          "assets/icons/icon-sidebar.png",
            color: kPrimaryLabelColor,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
      onPressed: triggerAnimation,
    );
  }
}