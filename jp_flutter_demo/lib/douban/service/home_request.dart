import 'package:jp_flutter_demo/douban/model/home_model.dart';
import 'package:jp_flutter_demo/douban/service/config.dart';
import 'package:jp_flutter_demo/douban/service/http_request.dart';

class JPHomeRequest {
  static Future<List<MovieItem>> requestMovieList(int start) async {
    // 1.构建URL
    final movieURL = "http://123.207.32.32:8001/api/douban/movie?start=$start&count=${JPHomeConfig.movieCount}";
    // https://douban.uieee.com/v2/movie/top250?start=0&count=20
    // https://douban-api.uieee.com/v2/movie/top250?start=0&count=20

    // 2.发送网络请求获取结果
    final result = await JPHttpRequest.request(movieURL);
    if (result == null) {
      throw Exception("the result is null");
    }
    final subjects = result["subjects"];

    // 3.将Map转成Model
    List<MovieItem> movies = [];
    for (var subject in subjects) {
      movies.add(MovieItem.fromMap(subject));
    }

    return movies;
  }
}