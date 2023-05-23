import 'package:dio/dio.dart';
import '../douban/service/config.dart';

final BaseOptions baseOptions = BaseOptions(baseUrl: JPHttpConfig.baseURL, connectTimeout: JPHttpConfig.timeout);
final Dio dio = Dio(baseOptions);

// 敲`Future<T> requestData`就自己出来这段代码了
Future<T> requestData<T>(String url, {String method = "get", Map<String, dynamic>? params}) async {
  // 1.创建单独配置
  final options = Options(method: method);
  // 2.发送网络请求
  try {
    Response response = await dio.request(url, queryParameters: params, options: options);
    return response.data; // 返回请求结果
  } on DioError catch(error) {
    return Future.error(error); // 直接抛出异常
  }
}