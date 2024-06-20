import 'package:dio/dio.dart';
import 'package:my_macos_app/models/token/token.dart';
import 'package:my_macos_app/preferences_client/preferences_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static late final Dio dioClient;

  static void initialize() {
    dioClient = Dio();
    dioClient.options.baseUrl =
        "https://rnxbo-106-195-37-59.a.free.pinggy.link/api/v1";
    dioClient.interceptors
      ..add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      )
      ..add(
        QueuedInterceptorsWrapper(
          onRequest: (options, handler) async {
            if (options.extra['authorizedRoute'] == true) {
              final Token? token = PreferencesClient.getToken();
              options.headers['Authorization'] = 'Bearer ${token?.accessToken}';
            }
            return handler.next(options);
          },
        ),
      );
  }
}
