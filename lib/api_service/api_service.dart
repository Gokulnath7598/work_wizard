import 'package:dio/dio.dart';
import 'package:my_macos_app/models/token/token.dart';
import 'package:my_macos_app/preferences_client/preferences_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static late final Dio dioClient;

  static String token =
      '''eyJhbGciOiJSUzI1NiIsImtpZCI6ImRmOGIxNTFiY2Q5MGQ1YjMwMjBlNTNhMzYyZTRiMzA3NTYzMzdhNjEiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiWWF6aGluaSBNYWxhciBQYXJpIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3dvcmstd2l6YXJkLWJmOTc5IiwiYXVkIjoid29yay13aXphcmQtYmY5NzkiLCJhdXRoX3RpbWUiOjE3MTg4ODE5MTIsInVzZXJfaWQiOiJvRnR2RjZlcUtsWkZwak1UTkd3N0JsTEI2TDgyIiwic3ViIjoib0Z0dkY2ZXFLbFpGcGpNVE5HdzdCbExCNkw4MiIsImlhdCI6MTcxODg4MTkxMiwiZXhwIjoxNzE4ODg1NTEyLCJlbWFpbCI6InlhemhpbmkubWFsYXJAcm9vdHF1b3RpZW50LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJtaWNyb3NvZnQuY29tIjpbImE1ZDIxMWQ2LWJjNTgtNDcwOS1iZmIzLTI4MWMwZWU4NzFkMCJdLCJlbWFpbCI6WyJ5YXpoaW5pLm1hbGFyQHJvb3RxdW90aWVudC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJtaWNyb3NvZnQuY29tIn19.FhukiFygrGKWZTFYZXysZOcQL1pYJmoW3OZ4FXN1LsC36QnzaNkp3hCABivt4KU5oi58jgbf5-Hmb-SWg2__G7pFgpG2fQc-j6eB4HYzYFdvAnuS1ENqbqNLvG7xYGYGACSv2QpMdjZO4Z-gjyRjbDWFke7F-Yf6wYEdUgPph1xMvRa2ZMKDQMTpFCOqHTvEP6I9BTxjEqHyUOSYUNneY5_MJ3rpOMup8KovqPG2l1-0QoEFC1NzD9WF7wF4RMYzh02tnoG0joLB-H1HKyg7KaUXjC-G9vAJjJgd4-tRpGBw1Tc2HL0Tk4u0587JRCJOKDepKW8vpxAg4qM-r4zl5Q''';

  static void initialize() {
    dioClient = Dio();
    dioClient.options.baseUrl =
        "https://rnnmj-106-195-37-59.a.free.pinggy.link/api/v1";
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
