import 'dart:async';
import 'package:dio/dio.dart';
import 'package:my_macos_app/core/constants/app_assets.dart';
import 'package:my_macos_app/models/daily_task.dart';
import 'api_repository.dart';


class DailyTaskService extends ApiRepository {
  //************************************ getDailyTasks *********************************//
  static Future<DailyTasks?> getDailyTasks() async {
    final Response res = await ApiRepository().apiClient.get(
        '/user/daily_tasks',
        options:
            Options(headers: {'Authorization': 'Bearer ${AppAssets.token}'}));
    return DailyTasks.fromMap(res.data as Map<String, dynamic>);
  }

//************************************ addDailyTask *********************************//
  static Future<DailyTask?> addDailyTask(
      {Map<String, dynamic>? objToApi}) async {
    final Response res = await ApiRepository().apiClient.post(
        '/user/daily_tasks',
        data: objToApi,
        options:
            Options(headers: {'Authorization': 'Bearer ${AppAssets.token}'}));
    return DailyTask.fromMap((res.data as Map<String, dynamic>)['daily_task']);
  }

//************************************ deleteDailyTask *********************************//
  static Future<void> deleteDailyTask({int? id}) async {
    await ApiRepository().apiClient.delete('/user/daily_tasks/$id',
        options:
            Options(headers: {'Authorization': 'Bearer ${AppAssets.token}'}));
  }
}
