import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/douban/model/home_model.dart';
import 'package:jp_flutter_demo/douban/widgets/jp_star_rating.dart';
import 'package:jp_flutter_demo/douban/widgets/jp_dashed_line.dart';

class JPHomeMovieItem extends StatelessWidget {
  final MovieItem movie;

  JPHomeMovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 8, color: Color(0xffcccccc)),
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildHeader(),
          SizedBox(height: 8,),
          buildContent(),
          SizedBox(height: 8,),
          buildFooter(),
        ],
      ),
    );
  }

  // 1.头部的排名
  Widget buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 238, 205, 144),
        borderRadius: BorderRadius.circular(3)
      ),
      child: Text("No.${movie.rank}", style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 131, 95, 36))),
    );
  }

  // 2.内容的布局
  Widget buildContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 电影海报
        buildContentImage(),
        SizedBox(width: 8,),
        // 电影信息
        Expanded(
          child: IntrinsicHeight( // 能使包裹的这一行的内容的高度保持一致
            child: Row(
              children: <Widget>[
                // 电影名字+评分+简介
                buildContentInfo(),
                SizedBox(width: 8,),
                // 虚线
                buildContentDashedLine(),
                SizedBox(width: 8,),
                // 想看
                buildContentWish()
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 2.1 电影海报
  Widget buildContentImage() {
    // ClipRRect -> ClipRadiusRect，专门用来做圆角裁剪
    return ClipRRect(
      child: Image.network(movie.imageURL, height: 170,),
      borderRadius: BorderRadius.circular(4),
    );
  }

  // 2.2 电影信息
  Widget buildContentInfo() {
    return Expanded( // 自适应伸缩，防止显示区域超出屏幕
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // buildContentInfoTitle1(),
          // buildContentInfoTitle2(),
          buildContentInfoTitle3(),
          SizedBox(height: 8,),
          buildContentInfoRate(),
          SizedBox(height: 8,),
          buildContentInfoDesc()
        ],
      ),
    );
  }

  // 2.2.1 图标+标题+年份
  //【方式1】：该方式目前还不能做到文字水平居中对齐，只能底部对齐
  Widget buildContentInfoTitle1() {
    return Stack(
      children: <Widget>[
        // 图标
        Padding(
          padding: EdgeInsets.only(top: 1),
          child: Icon(Icons.play_circle_outline, color: Colors.redAccent, size: 25,),
        ),
        Text.rich(
          TextSpan(
            children: [
              // 标题
              TextSpan(
                text: "      " + movie.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // 年份
              TextSpan(
                text: " (${movie.playDate})",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              )
            ]
          ),
          maxLines: 2,
        ),
      ],
    );
  }
  //【方式2】：该方式目前存在些许问题 --- 富文本的高度不准确，超过一行时会跟 IntrinsicHeight 有冲突（显示有超出区域）
  // 这个问题出自于：设置年份的 Text 的 style 和 WidgetSpan 的 style 有冲突
  Widget buildContentInfoTitle2() {
    return Text.rich(
      TextSpan(
        children: [
          // 1.图标、标题、年份全部都使用 WidgetSpan，
          // 2.然后图标、标题设置 alignment 为 PlaceholderAlignment.middle，可以使图标、标题水平居中
          // 3.年份设置 alignment 为 PlaceholderAlignment.bottom，与图标、标题底部对齐

          // 图标
          WidgetSpan(
            child: Icon(Icons.play_circle_outline, color: Colors.redAccent, size: 25),
            baseline: TextBaseline.ideographic,
            alignment: PlaceholderAlignment.middle
          ),

          // 间隔
          WidgetSpan(
              child: Text(" ", style: TextStyle(fontSize: 15)),
              alignment: PlaceholderAlignment.middle
          ),

          // 标题
          // 不使用一整段标题，不然长度不够不会把超出部分换行，而是整个换行
//          WidgetSpan(
//              child: Text("${movie.title}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//              baseline: TextBaseline.ideographic,
//              alignment: PlaceholderAlignment.middle
//          ),
          // 将标题每个字拆出来，每个字单独包装成一个Widget来排布
          // 1. runes：将一段文字拆解成一个个文字的编码放到一个数组返回
          // 2. map：映射，遍历每个元素，回调函数：对每个元素做什么，返回：Iterable<T>
          // 3. toList()：将 Iterable 转成列表（数组）
          // 4. ...：把数组展开，也就是将里面元素一个个取出来返回，而不是返回一个数组（ [1, 2, 3] -> 1, 2, 3 ）
          ...movie.title.runes.map((rune){
            return WidgetSpan(
                child: Text(String.fromCharCode(rune), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                alignment: PlaceholderAlignment.middle
            );
          }).toList(),

          // 间隔
          WidgetSpan(
              child: Text(" ", style: TextStyle(fontSize: 15)),
              alignment: PlaceholderAlignment.middle
          ),

          // 年份
          WidgetSpan(
              // Text 的 style 和 WidgetSpan 的 style 貌似有冲突
              // 设置了 Text 的 style，alignment 就无效，不设置，alignment 就有效，但 WidgetSpan 的 style 影响不了 Text
              // 这里的冲突导致<<显示有超出区域>>的问题
              child: Text("(${movie.playDate})", style: TextStyle(fontSize: 18, color: Colors.grey)),
              style: TextStyle(fontSize: 18, color: Colors.grey),
              alignment: PlaceholderAlignment.bottom
          )
        ],
      )
    );
  }
  //【方式3】：...movie.title.runes.map((rune){ ... }).toList() 的 ... 被弃用了，换成把所有 WidgetSpan 都丢到一个数组里面的方式
  // 还是存在问题：富文本的高度不准确，超过一行时会跟 IntrinsicHeight 有冲突（显示有超出区域）
  // 这个问题出自于：设置年份的 Text 的 style 和 WidgetSpan 的 style 有冲突
  Widget buildContentInfoTitle3() {
    List<InlineSpan> getSpans() {
      List<InlineSpan> spans = [];

      // 图标
      spans.add(WidgetSpan(
        child: Icon(Icons.play_circle_outline, color: Colors.redAccent, size: 25),
        baseline: TextBaseline.ideographic,
        alignment: PlaceholderAlignment.middle
      ));

      // 间隔
      spans.add(WidgetSpan(
        child: Text(" ", style: TextStyle(fontSize: 15)),
        alignment: PlaceholderAlignment.middle
      ));

      // 标题
      spans.addAll(movie.title.runes.map((rune){
        return WidgetSpan(
            child: Text(String.fromCharCode(rune), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            alignment: PlaceholderAlignment.middle
        );
      }).toList());

      // 间隔
      spans.add(WidgetSpan(
        child: Text(" ", style: TextStyle(fontSize: 15)),
        alignment: PlaceholderAlignment.middle
      ));

      // 年份
      spans.add(WidgetSpan(
          // Text 的 style 和 WidgetSpan 的 style 貌似有冲突
          // 设置了 Text 的 style，alignment 就无效，不设置，alignment 就有效，但 WidgetSpan 的 style 影响不了 Text
          // 这里的冲突导致<<显示有超出区域>>的问题
          child: Text("(${movie.playDate})", style: TextStyle(fontSize: 18, color: Colors.grey)),
          style: TextStyle(fontSize: 18, color: Colors.grey),
          alignment: PlaceholderAlignment.bottom
      ));

      return spans;
    }

    return Text.rich(
      TextSpan(
        children: getSpans(),
      )
    );
  }

  // 2.2.2 评分
  Widget buildContentInfoRate() {
    // FittedBox：当 子Widget 超出<最大显示区域>时，将 子Widget 按比例缩小至<最大显示大小>
    return FittedBox(
      child: Row(
        children: <Widget>[
          JPStarRating(rating: movie.rating, size: 20),
          SizedBox(width: 6,),
          Text("${movie.rating}", style: TextStyle(fontSize: 16))
        ],
      ),
    );
  }

  // 2.2.3 类型+导演+演员
  Widget buildContentInfoDesc() {
    // 1.字符串拼接
    final genresStr = movie.genres.join(" "); // join：将字符串数组拼接成一个字符串，以传入的参数为分隔符
    final directorStr = movie.director.name;
    final actorStr = movie.casts.map((item) => item.name).join(" "); // map：映射，遍历每个元素，回调函数：对每个元素做什么，返回：Iterable<T>
    return Text(
      "$genresStr / $directorStr / $actorStr",
      style: TextStyle(fontSize: 16),
      maxLines: 2, // 最多两行
      overflow: TextOverflow.ellipsis,
    );
  }

  // 2.3 虚线
  Widget buildContentDashedLine() {
    return Container(
      // height: 100,
      child: JPDashedLine(
        axis: Axis.vertical,
        dashedWidth: 0.5,
        dashedHeight: 5,
        count: 12,
        color: Colors.amber,
      )
    );
  }

  // 2.4 想看
  Widget buildContentWish() {
    return Container(
      // height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/home/wish.png", width: 45,),
          Text("想看", style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 235, 170, 60)),)
        ],

      ),
    );
  }

  // 3.尾部的布局
  Widget buildFooter() {
    return Container(
      width: double.infinity, 
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color(0xfff2f2f2),
          borderRadius: BorderRadius.circular(6)
      ),
      child: Text(movie.originalTitle, style: TextStyle(fontSize: 18, color: Color(0xff777777))),
    );
  }
}
