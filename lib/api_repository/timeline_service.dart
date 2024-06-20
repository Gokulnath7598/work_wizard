import 'dart:async';
import 'package:dio/dio.dart';
import 'package:my_macos_app/api_service/api_service.dart';
import 'package:my_macos_app/blocs/timeline/timeline_bloc.dart';
import 'package:my_macos_app/models/daily_task.dart';

import '../models/time_line.dart';

class TimeLineService extends ApiService {
  //************************************ getTimeLineTasks *********************************//
  static Future<List<TimeLine>?> getTimeLineTasks({Map<String, dynamic>? queryParams}) async {
    final Response res = await ApiService.dioClient.get(
        '/user/tasks',
        queryParameters: queryParams,
        options:
        Options(headers: {'Authorization': ApiService.token}));
    // return (res.data['tasks'] as List<dynamic>).map((dynamic e) => LoansListing.fromJson(e as Map<String, dynamic>?)).toList();
    return [];
  }

}
