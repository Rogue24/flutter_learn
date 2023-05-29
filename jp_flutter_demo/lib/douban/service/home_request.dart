import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:jp_flutter_demo/douban/model/home_model.dart';

class JPHomeRequest {
  static Future<List<MovieItem>> requestMovieList(int start) async {
    // 1.构建URL
    // final movieURL = "http://123.207.32.32:8001/api/douban/movie?start=$start&count=${JPHomeConfig.movieCount}";
    // https://douban.uieee.com/v2/movie/top250?start=0&count=20
    // https://douban-api.uieee.com/v2/movie/top250?start=0&count=20

    // 2.发送网络请求获取结果
    // final result = await JPHttpRequest.request(movieURL);
    // if (result == null) {
    //   throw Exception("the result is null");
    // }
    // final subjects = result["subjects"];

    // 接口已经不好使了，所以用本地的json文件
    String jsonStr = await rootBundle.loadString("assets/json/douban_top250.json");
    final jsonResult = json.decode(jsonStr);
    final subjects = jsonResult["subjects"];

    // 3.将Map转成Model
    counter = 1;
    List<MovieItem> movies = [];
    for (var subject in subjects) {
      movies.add(MovieItem.fromMap(subject));
    }

    return movies;
  }
}