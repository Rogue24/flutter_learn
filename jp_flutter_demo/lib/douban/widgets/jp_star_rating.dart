import 'package:flutter/material.dart';

class JPStarRating extends StatefulWidget {
  final double rating;
  final double maxRating;
  final int count;
  final double size;
  final Color unselectedColor;
  final Color selectedColor;
  final Widget unselectedImage;
  final Widget selectedImage;

  JPStarRating({
    required double rating,
    this.maxRating = 10,
    this.count = 5,
    this.size = 30,
    this.unselectedColor = Colors.grey,
    this.selectedColor = Colors.yellow,
    Widget? unselectedImage,
    Widget? selectedImage
  }) : rating = rating > maxRating ? maxRating : rating,
       unselectedImage = unselectedImage ?? Icon(Icons.star_border, color: unselectedColor, size: size),
       selectedImage = selectedImage ?? Icon(Icons.star, color: selectedColor, size: size);

  @override
  _JPStarRatingState createState() => _JPStarRatingState();
}

class _JPStarRatingState extends State<JPStarRating> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Row的宽度为包裹内容的宽度（最小）
        Row(mainAxisSize: MainAxisSize.min, children: buildUnSelectedStar()),
        Row(mainAxisSize: MainAxisSize.min, children: buildSelectedStar())
      ],
    );
  }

  List<Widget> buildUnSelectedStar() {
    return List.generate(widget.count, (index) {
      return widget.unselectedImage;
    });
  }

  List<Widget> buildSelectedStar() {
    List<Widget> stars = [];

    // 一颗星占多少分
    double oneValue = widget.maxRating / widget.count;

    // 共多少颗星
    double starCount = widget.rating / oneValue;

    // 整数部分
    int entireCount = starCount.floor(); // 向下取整
    for (var i = 0; i < entireCount; i++) {
      stars.add(widget.selectedImage);
    }

    // 浮点部分（小于1颗星的宽度）
    double leftWidth = widget.size * (starCount - entireCount);
    final leftStar = ClipRect(child: widget.selectedImage, clipper: JPStarClipper(leftWidth));
    stars.add(leftStar);

    return stars;
  }
}

// ClipRect的clipper参数类型为CustomClipper<Rect>，这是个抽象类，需要自定义一个子类，并且返回类型是规定为Rect的泛型
class JPStarClipper extends CustomClipper<Rect> {
  final double width;
  JPStarClipper(this.width);

  @override
  getClip(Size size) {
    // 返回一个Rect，这是能显示的区域，少于这个区域会被裁剪掉
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(JPStarClipper oldClipper) {
    return oldClipper.width != this.width; // 是否重新裁剪？--- 宽度不同时才需要重新裁剪
  }
}