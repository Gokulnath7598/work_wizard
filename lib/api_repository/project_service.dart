import 'dart:async';
import 'package:dio/dio.dart';
import 'package:my_macos_app/core/constants/app_assets.dart';
import 'package:my_macos_app/models/user.dart';
import 'api_repository.dart';

class ProjectService extends ApiRepository {
  //************************************ getDailyTasks *********************************//
  static Future<User?> getUserDetails() async {
    final Response res = await ApiRepository().apiClient.get('/user/users',
        options:
            Options(headers: {'Authorization': 'Bearer ${AppAssets.token}'}));
    return User.fromMap(res.data as Map<String, dynamic>);
  }

//************************************ update-user *********************************//
  static Future<User?> updateUser({Map<String, dynamic>? objToApi}) async {
    final Response res = await ApiRepository().apiClient.put('/user/users/1',
        data: objToApi,
        options:
            Options(headers: {'Authorization': 'Bearer ${AppAssets.token}'}));
    return User.fromMap(res.data as Map<String, dynamic>);
  }
}
