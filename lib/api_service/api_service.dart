import 'package:dio/dio.dart';
import 'package:my_macos_app/models/token/token.dart';
import 'package:my_macos_app/preferences_client/preferences_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static late final Dio dioClient;

  static String token =
      '''eyJhbGciOiJSUzI1NiIsImtpZCI6ImRmOGIxNTFiY2Q5MGQ1YjMwMjBlNTNhMzYyZTRiMzA3NTYzMzdhNjEiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiWWF6aGluaSBNYWxhciBQYXJpIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3dvcmstd2l6YXJkLWJmOTc5IiwiYXVkIjoid29yay13aXphcmQtYmY5NzkiLCJhdXRoX3RpbWUiOjE3MTg4ODQ2NzYsInVzZXJfaWQiOiJvRnR2RjZlcUtsWkZwak1UTkd3N0JsTEI2TDgyIiwic3ViIjoib0Z0dkY2ZXFLbFpGcGpNVE5HdzdCbExCNkw4MiIsImlhdCI6MTcxODg4NDY3NiwiZXhwIjoxNzE4ODg4Mjc2LCJlbWFpbCI6InlhemhpbmkubWFsYXJAcm9vdHF1b3RpZW50LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJtaWNyb3NvZnQuY29tIjpbImE1ZDIxMWQ2LWJjNTgtNDcwOS1iZmIzLTI4MWMwZWU4NzFkMCJdLCJlbWFpbCI6WyJ5YXpoaW5pLm1hbGFyQHJvb3RxdW90aWVudC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJtaWNyb3NvZnQuY29tIn19.GixpJLj8AbCwpQ7KodvsWdX-wqAxNqlNtGPFH4F9LP6v3iCMfKnXnwElOe7RaJK2DxMZbsDGh66Q80_ovzd5q-sDSfoyMRBnZWwaut6NhjUV88ob6uqlqcpACTv4J0dpI9HIJoNfHqdf6TkSCqCpuPMHqPin5w_WU82yOenL7Dnkdumdz7tEBTxdllFYoV1PaOxvfkcO-AU7abycetwhcpLyonOqvTU0p6HX67HdGKCvKGgt3SZrBz-xS0BEAVy3n1EofAT8Dt7G04o2iOz7N__hlqCrnwGsYxt_ktq_nUce8UjshiMPyWAVDWJSyweiBan9IIMOB8SMRoADr86img''';

  static void initialize() {
    dioClient = Dio();
    dioClient.options.baseUrl =
        "https://rnqgv-106-195-37-59.a.free.pinggy.link/api/v1";
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
