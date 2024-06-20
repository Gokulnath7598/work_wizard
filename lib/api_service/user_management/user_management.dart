import 'dart:async';

import 'package:dio/dio.dart';
import 'package:my_macos_app/api_service/api_service.dart';

import '../../models/models.dart';

class UserManagement {
  static FutureOr<Map<String, dynamic>?> authenticate({
    required Token token,
  }) async {
    final Response<Map<String, dynamic>?> response =
        await ApiService.dioClient
        .get<Map<String, dynamic>?>('/user/users',
            options: Options(
                headers: {'Authorization': 'Bearer ${token.accessToken}'})
    );

    return {
      'user': AppUser.fromJson(
        response.data?['user'] as Map<String, dynamic>,
      ),
      'token': Token.fromJson(
        {
          'token': response.data?['token'] as String?,
        },
      ),
    };
  }
}
