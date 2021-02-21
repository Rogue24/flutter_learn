import 'package:flutter/material.dart';

import 'package:excellent_cuisine/ui/extension/int_extension.dart';

class JPOperationItem extends StatelessWidget {
  final Widget _icon;
  final String _title;
  final Color _titleColor;
  JPOperationItem(this._icon, this._title, {Color titleColor = Colors.black}) : this._titleColor = titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.px,
      padding: EdgeInsets.symmetric(vertical: 12.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _icon,
          SizedBox(width: 3.px),
          Text(_title, style: TextStyle(color:  _titleColor)) // 使用默认样式
        ],
      ),
    );
  }
}