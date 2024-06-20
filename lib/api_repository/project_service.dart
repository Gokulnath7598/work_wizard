import 'dart:async';
import 'package:dio/dio.dart';
import 'package:my_macos_app/api_service/api_service.dart';
import 'package:my_macos_app/models/projects.dart';
import 'package:my_macos_app/models/user.dart';

class ProjectService extends ApiService {
  //************************************ getDailyTasks *********************************//
  static Future<User?> getUserDetails() async {
    final Response res = await ApiService.dioClient.get('/user/users',
        options: Options(headers: {'Authorization': ApiService.token}));
    return User.fromMap(res.data as Map<String, dynamic>);
  }

  //************************************ getDailyTasks *********************************//
  static Future<Projects?> getProjects() async {
    final Response res = await ApiService.dioClient
        .get('/user/projects',
        options:
            Options(headers: {'Authorization': ApiService.token}));
    return Projects.fromMap(res.data as Map<String, dynamic>);
  }

//************************************ update-user *********************************//
  static Future<User?> updateUser({Map<String, dynamic>? objToApi}) async {
    final Response res = await ApiService.dioClient.put('/user/users/1',
        data: objToApi,
        options:
            Options(headers: {'Authorization': ApiService.token}));
    return User.fromMap(res.data as Map<String, dynamic>);
  }
}
