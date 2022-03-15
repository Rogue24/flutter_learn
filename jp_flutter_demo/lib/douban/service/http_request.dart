import 'package:dio/dio.dart'; // 导入dio
import 'package:jp_flutter_demo/douban/service/config.dart';
import 'package:jp_flutter_demo/JPLog.dart';

class JPHttpRequest {

  static final BaseOptions baseOptions = BaseOptions(baseUrl: JPHttpConfig.baseURL, connectTimeout: JPHttpConfig.timeout);
  static final Dio dio = Dio(baseOptions);

  static Future<T> request<T>(String url, {String method = "get",
                                           Map<String, dynamic>? params,
                                           Interceptor? inter}) async {

    // 1.创建单独配置
    final options = Options(method: method);

    // 拦截器（可以在事件发生前拦截住去做一些处理）
    // 1.创建默认的全局拦截器
    Interceptor interceptor = InterceptorsWrapper(
      // typedef InterceptorSendCallback = void Function(
      //   RequestOptions options,
      //   RequestInterceptorHandler handler,
      // );
      onRequest: (options, handler) {
        JPrint("请求拦截");
        handler.next(options); // 执行下一步
      },
      // typedef InterceptorSuccessCallback = void Function(
      //   Response e,
      //   ResponseInterceptorHandler handler,
      // );
      onResponse: (response, handler) {
        JPrint("响应拦截");
        handler.next(response); // 执行下一步
      },
      // typedef InterceptorErrorCallback = void Function(
      //   DioError e,
      //   ErrorInterceptorHandler handler,
      // );
      onError: (error, handler) {
        JPrint("错误拦截");
        handler.next(error); // 执行下一步
      }
    );
    // 2.添加全局拦截器
    List<Interceptor> interceptors = [interceptor];
    // 3.添加外界的拦截器
    if (inter != null) {
      interceptors.add(inter);
    }
    // 4.统一添加到拦截器中
    dio.interceptors.addAll(interceptors);

    // 2.发送网络请求
    try {
      Response response = await dio.request(url, queryParameters: params, options: options);
      return response.data; // 返回请求结果
    } on DioError catch(error) {
      return Future.error(error); // 直接抛出异常
    }
  }
}