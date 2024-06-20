import 'dart:async';
import 'package:dio/dio.dart';
import 'package:my_macos_app/models/daily_task.dart';
import 'api_repository.dart';

String token =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6ImRmOGIxNTFiY2Q5MGQ1YjMwMjBlNTNhMzYyZTRiMzA3NTYzMzdhNjEiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiWWF6aGluaSBNYWxhciBQYXJpIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3dvcmstd2l6YXJkLWJmOTc5IiwiYXVkIjoid29yay13aXphcmQtYmY5NzkiLCJhdXRoX3RpbWUiOjE3MTg4NjcwNjQsInVzZXJfaWQiOiJvRnR2RjZlcUtsWkZwak1UTkd3N0JsTEI2TDgyIiwic3ViIjoib0Z0dkY2ZXFLbFpGcGpNVE5HdzdCbExCNkw4MiIsImlhdCI6MTcxODg2NzA2NCwiZXhwIjoxNzE4ODcwNjY0LCJlbWFpbCI6InlhemhpbmkubWFsYXJAcm9vdHF1b3RpZW50LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJtaWNyb3NvZnQuY29tIjpbImE1ZDIxMWQ2LWJjNTgtNDcwOS1iZmIzLTI4MWMwZWU4NzFkMCJdLCJlbWFpbCI6WyJ5YXpoaW5pLm1hbGFyQHJvb3RxdW90aWVudC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJtaWNyb3NvZnQuY29tIn19.aY6WNxH3TzTqW7fhKKB05eq6hAKD3Ig7abRtdIBSbh_QvCt1tog1nroA-vfQDjM0MAifP8XG64fNtKfYCYuV34eaxW0qcRfrqsVcUY95DQt_U9FqSfbOen5yW3s6RKYZxVbW1EChswJV5BHU8wqzfS8dLyFFGS_4tzHajbMlkMC-KZ0XuJdWU1wcWpwerCyIW01nprjnpamHBPHP-UdBemPBYteG-n0Odw4Jd0tBrdtcSQxKT_4U8gm-WlqtJ0xuRTZu3HSS5Ksi8Uc7YKlsxzWxKHd1zRpqtoUjUyj6x8bebMZAlS7z5mVPIdAGfu8Tjdu3uofilukcMNIoqFe9Rw';

class DailyTaskService extends ApiRepository {
  //************************************ getDailyTasks *********************************//
  static Future<DailyTasks?> getDailyTasks() async {
    final Response res = await ApiRepository().apiClient.get(
        '/user/daily_tasks',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return DailyTasks.fromMap(res.data as Map<String, dynamic>);
  }

//************************************ addDailyTask *********************************//
  static Future<DailyTask?> addDailyTask(
      {Map<String, dynamic>? objToApi}) async {
    final Response res = await ApiRepository().apiClient.post(
        '/user/daily_tasks',
        data: objToApi,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return DailyTask.fromMap((res.data as Map<String, dynamic>)['daily_task']);
  }

//************************************ deleteDailyTask *********************************//
  static Future<void> deleteDailyTask({int? id}) async {
    await ApiRepository().apiClient.delete('/user/daily_tasks/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
  }
}
