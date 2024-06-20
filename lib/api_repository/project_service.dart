import 'dart:async';
import 'package:dio/dio.dart';
import 'package:my_macos_app/api_service/api_service.dart';
import 'package:my_macos_app/models/user.dart';
import 'api_repository.dart';

class ProjectService extends ApiRepository {
  //************************************ getDailyTasks *********************************//
  static Future<User?> getUserDetails() async {
    final Response res = await ApiService.dioClient
        .get('/user/users',
        options:
            Options(extra: {'authorizedRoute': true}));
    return User.fromMap(res.data as Map<String, dynamic>);
  }

//************************************ update-user *********************************//
  static Future<User?> updateUser({Map<String, dynamic>? objToApi}) async {
    final Response res = await ApiService.dioClient.put('/user/users/1',
        data: objToApi,
        options:
            Options(extra: {'authorizedRoute': true}));
    return User.fromMap(res.data as Map<String, dynamic>);
  }
}
