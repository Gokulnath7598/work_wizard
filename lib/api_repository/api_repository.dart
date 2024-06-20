import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiRepository {

  static BaseOptions options = BaseOptions(
      baseUrl: "https://rnoay-106-195-37-59.a.free.pinggy.link/api/v1");
  final Dio apiClient = Dio(options)
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
}
