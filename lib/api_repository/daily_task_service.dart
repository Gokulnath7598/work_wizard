import 'dart:async';
import 'package:dio/dio.dart';
import 'package:my_macos_app/api_service/api_service.dart';
import 'package:my_macos_app/models/daily_task.dart';

class DailyTaskService extends ApiService {
  //************************************ getDailyTasks *********************************//
  static Future<DailyTasks?> getDailyTasks() async {
    final Response res = await ApiService.dioClient.get(
        '/user/daily_tasks',
        options:
            Options(headers: {'Authorization': ApiService.token}));
    return DailyTasks.fromMap(res.data as Map<String, dynamic>);
  }

//************************************ addDailyTask *********************************//
  static Future<DailyTask?> addDailyTask(
      {Map<String, dynamic>? objToApi}) async {
    final Response res = await ApiService.dioClient.post(
        '/user/daily_tasks',
        data: objToApi,
        options:
            Options(headers: {'Authorization': ApiService.token}));
    return DailyTask.fromMap((res.data as Map<String, dynamic>)['daily_task']);
  }

//************************************ deleteDailyTask *********************************//
  static Future<void> deleteDailyTask({int? id}) async {
    await ApiService.dioClient.delete('/user/daily_tasks/$id',
        options:
            Options(headers: {'Authorization': ApiService.token}));
  }
}
