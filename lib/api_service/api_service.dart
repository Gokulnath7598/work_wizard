import 'package:dio/dio.dart';
import 'package:my_macos_app/models/token/token.dart';
import 'package:my_macos_app/preferences_client/preferences_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static late final Dio dioClient;

  static String token =
      '''eyJhbGciOiJSUzI1NiIsImtpZCI6ImRmOGIxNTFiY2Q5MGQ1YjMwMjBlNTNhMzYyZTRiMzA3NTYzMzdhNjEiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiWWF6aGluaSBNYWxhciBQYXJpIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3dvcmstd2l6YXJkLWJmOTc5IiwiYXVkIjoid29yay13aXphcmQtYmY5NzkiLCJhdXRoX3RpbWUiOjE3MTg4NzY5MTQsInVzZXJfaWQiOiJvRnR2RjZlcUtsWkZwak1UTkd3N0JsTEI2TDgyIiwic3ViIjoib0Z0dkY2ZXFLbFpGcGpNVE5HdzdCbExCNkw4MiIsImlhdCI6MTcxODg3NjkxNCwiZXhwIjoxNzE4ODgwNTE0LCJlbWFpbCI6InlhemhpbmkubWFsYXJAcm9vdHF1b3RpZW50LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJtaWNyb3NvZnQuY29tIjpbImE1ZDIxMWQ2LWJjNTgtNDcwOS1iZmIzLTI4MWMwZWU4NzFkMCJdLCJlbWFpbCI6WyJ5YXpoaW5pLm1hbGFyQHJvb3RxdW90aWVudC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJtaWNyb3NvZnQuY29tIn19.BhpSVms_pShgRHeG8YKp5cOVvy3BfKp0vyj6ohjZuVJMVngGf8QEyZgN9K1yvo2HeqseYj7yMTxQ1V4B-KqDmvr6P9U-2SxVvPJw3P_sUYE1_otVHQ-5rcKQ5_b1ojbcDHhI7xxbaf9Sit5wvZa6zqlN6lbyFsF2AXcj6VBIs-T3z5RgH_RO10d9Egx_L0C8m1Pd7iv4P4_u9SYOIAqxS9nRP2weem8430bw9TqElsklrgViAjKYhhMP6qJhJ50SGPZQ-5n6Ai0r1hJmNt98xRYDmpMvurcbqCzP-f2I3kl7DEkllnV19xe8u1zuYD3nxO3kcBbs5crh-bbSxJaKpA''';

  static void initialize() {
    dioClient = Dio();
    dioClient.options.baseUrl =
        "https://rngrv-106-195-37-59.a.free.pinggy.link/api/v1";
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
