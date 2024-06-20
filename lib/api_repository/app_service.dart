import 'dart:async';
import 'package:rq_network_flutter/networking/response_model.dart';
import 'api_repository.dart';

class AppService extends ApiRepository {
  //************************************ update-on-boarding-status *********************************//
  static Future<void> updateOnboardingStatus({Map<String, dynamic>? data}) async {
    await ApiRepository.apiService.put(
        data: data,
        requiresAuthToken: true,
        endpoint: '/user/onboarding/status',
        converter: (ResponseModel<Map<String, dynamic>?> response) {
          return response;
        });
  }
}
