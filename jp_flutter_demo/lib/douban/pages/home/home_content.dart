import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/douban/model/home_model.dart';
import 'package:jp_flutter_demo/douban/service/home_request.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'home_movie_item.dart';

class JPHomeContent extends StatefulWidget {
  @override
  _JPHomeContentState createState() => _JPHomeContentState();
}

class _JPHomeContentState extends State<JPHomeContent> {

  final List<MovieItem> movies = [];

  @override
  void initState() {
    super.initState();

    JPrint("发送网络请求");
    JPHomeRequest.requestMovieList(0).then((result){
      JPrint("请求成功");
      setState(() {
        movies.addAll(result);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return JPHomeMovieItem(movies[index]);
        }
    );
  }
}
