import 'package:dio/dio.dart';
import 'package:flutter_velog_sample/main.dart';

class DioServices {
  static final DioServices _dioServices = DioServices._internal();
  factory DioServices() => _dioServices;
  Map<String, dynamic> dioInformation = {};

  static Dio _dio = Dio();

  DioServices._internal() {
    BaseOptions _options = BaseOptions(
      baseUrl: "",
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      sendTimeout: const Duration(milliseconds: 10000),
      // headers: {},
    );
    _dio = Dio(_options);
    _dio.interceptors.add(DioInterceptor());
  }

  Dio to() {
    return _dio;
  }
}

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.e("BaseUrl ${options.baseUrl}");
    logger.e("Path ${options.path}");
    logger.e("Parameters ${options.queryParameters}");
    logger.e("Data ${options.data}");
    logger.e("Connect Timeout ${options.connectTimeout}");
    logger.e("Send Timeout ${options.sendTimeout}");
    logger.e("Receive Timeout ${options.receiveTimeout}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.e(response.statusCode);
    logger.e(response.data);
    logger.e("BaseUrl ${response.requestOptions.baseUrl}");
    logger.e("Path ${response.requestOptions.path}");
    logger.e("Parameters ${response.requestOptions.queryParameters}");
    logger.e("Data ${response.requestOptions.data}");
    logger.e("Connect Timeout ${response.requestOptions.connectTimeout}");
    logger.e("Send Timeout ${response.requestOptions.sendTimeout}");
    logger.e("Receive Timeout ${response.requestOptions.receiveTimeout}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    logger.e("Error ${err.error}");
    logger.e("Error Message ${err.message}");
    super.onError(err, handler);
  }
}
